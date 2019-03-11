module LessonsHelper
  def gravatar_url(instructor, options = { size: 180 })
    gravatar_id = Digest::MD5::hexdigest(instructor.email.downcase)
    size = options[:size]
    "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}&d=mp"
  end
end
