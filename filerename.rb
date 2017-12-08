Dir.chdir("text")
#폴더 내의 파일들을 확인하고, 파일명을 수정한다
#pwd  present working directory
#puts Dir.entries(Dir.pwd)
puts Dir.entries(Dir.pwd).reject { |e| e[0]=='.' }
files = Dir.entries(Dir.pwd).reject { |e| e[0]=='.' }

#첫번째 자리가 .인 애들을 reject 시킨다
files.each do |name|
  File.rename(name, name.gsub("new","new_"))
end
puts
puts Dir.entries(Dir.pwd).reject { |e| e[0]=='.' }
