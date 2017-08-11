begin
  if UserAgentsPool.size == 0
    ENV.fetch('NUMBER_OF_USER_AGENTS', 3).to_i.times do
      UserAgentsPool.generate
    end
  end
rescue
  puts $ex
end
