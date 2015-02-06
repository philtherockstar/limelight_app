#!/usr/bin/env ruby

require 'sqlite3'
require 'active_record'
require 'csv'
require '../app/models/property.rb'
require '../app/models/bid.rb'
require '../app/models/client.rb'
require '../app/models/realtor.rb'
require '../app/models/stage.rb'
require '../app/models/status.rb'

ActiveRecord::Base.establish_connection(
    :adapter        => "sqlite3",
    :database       => "development.sqlite3"
)

class StageRow
  attr_accessor :day, :mon, :month, :year, :stage_date, :status, :total, :rent, :address, :city, :realtor, :asking_price, :selling_price
  def initialize
  end
end

realtors_processed=[]
CSV.foreach("staging_house_count.csv") do |row|
 
  sr = StageRow.new
  sr.day=row[3].split('-')[0] if row[3]
  sr.mon=row[3].split('-')[1] if row[3]
  sr.year=row[17] if row[17]
  sr.status=row[4] if row[4]
  sr.total=row[5] if row[5]
  sr.rent=row[6] if row[6]
  sr.address=row[10] if row[10]
  sr.city=row[11] if row[11]
  sr.realtor=row[12] if row[12]
  sr.month=row[9]
  sr.asking_price=row[7]
  sr.selling_price=row[8]

  next if sr.address=="Address"
  next if sr.address=="class"
  next if sr.address=="christina"
  next if sr.address=="also studio"
  next if sr.address==""
  next if sr.address=="moms bathroom"
  next if sr.address.nil?

  begin
    Property.transaction do
      p = Property.where("lower(address) = ?",sr.address.downcase).first_or_create
      p.address = sr.address
      p.city = sr.city
      p.state_id = 6
      p.country_id = 226
      p.listing_price = sr.asking_price
      p.selling_price = sr.selling_price
      p.business_id = 1
      p.save

      realtor_last_name=nil
      realtor_first_name=nil
      realtor=nil
      if sr.realtor 
        realtor=sr.realtor.split(' ') 
        realtor_first_name=realtor[0] 
        realtor_last_name=realtor[1]
        puts "realtor_last_name=#{realtor_last_name}"
        r = Realtor.where("lower(first_name) = '#{realtor_first_name.downcase}' and lower(last_name) = '#{realtor_last_name.downcase}'") if realtor_last_name
        if r.nil? || r.size == 0 
          r = Realtor.new
          r.first_name = realtor_first_name
          r.last_name = realtor_last_name
          r.save unless realtors_processed.include?(sr.realtor)
          realtors_processed << sr.realtor
        end
      end

      s = Stage.new
      s.property_id = p.id 
      s.realtor_id = r.id  if sr.realtor && r.respond_to?(:id)
      s.total = sr.total if sr.total
      s.rent = sr.rent if sr.rent
      if (sr.year && sr.month && sr.day)
        s.stage_date = Date.new(sr.year.to_i,sr.month.to_i,sr.day.to_i)
      end
      s.save if p.id
    end
  #puts sr.year.to_i,sr.month.to_i,sr.day.to_i
  rescue Exception => e
    puts e.message
    puts "property:"
    puts p.inspect
    puts "sr"
    puts sr.inspect
    puts "row"
    puts row.inspect
  #  puts sr.year.to_i,sr.month.to_i,sr.day.to_i
    exit
  end

end

