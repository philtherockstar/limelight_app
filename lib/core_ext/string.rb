class String
  def stripped
    self.downcase.gsub(/[^a-z]/i, '')
  end
end
