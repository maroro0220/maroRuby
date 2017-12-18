def hello
  puts "Hi~!"
  yield
  puts "Byeeeee"
end
hello {puts "multicampus!"}
#함수를 호출 하면 함수명 뒤에 넘겨준 값을 yield위치에서 출력함.
