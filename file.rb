#0. file.rb의 위치는 rubyworkspace 폴더 안에 있다
# 1. text 폴더로 들어간다
Dir.chdir("text")

# 2. 파일을 만든다
#File.new("newfile.txt","w+")
#open하면 없는 파일은 만들어줌
20.times do |i|
  i+=1
  File.open("newfile#{i}.txt","w+") do |fileeee|
    #''작은 따옴표로 하면 #{}를 인식 못함. ""이걸로 해줘야함
    fileeee.write("hiiii!#{i}")
  end
end
#3. 파일에 내용을 입력한다.
