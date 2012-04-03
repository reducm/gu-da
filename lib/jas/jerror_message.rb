module JError
  def jerrors
    as = []
    if self.errors.messages.length > 0
        errors.messages.each{|k, v| as << v.join(', ')}
        as.join(', ')
    else
      nil
    end
  end
end

