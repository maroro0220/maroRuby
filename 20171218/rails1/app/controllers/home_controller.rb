class HomeController < ApplicationController
#컨트롤러는 액션의 모음이다
#모델과 뷰 사이의 중간관리자이다
#route에서 .erb로 넘어가기 전에 들러서 해당 def 실행하고 erb:는 생략되어있지만 실행 후 해당 .erb로 이동


#actions
#app/views/컨트롤러이름/액션이름.html.erb
#app/views/home/index.html/erb
  def index
  end
#action
#app/views/home/lotto.html
  def lotto
    @lotto=(1..45).to_a.sample(6).sort
  end
  def welcome
  @name=  params[:name]
  end
  def squre
    @n=params[:num].to_i
  end
  def lunch
    @lunkey=["Apple","Banana","Carrot","Dessert"].sample
    @lunch={"Apple"=>"https://www.apple.com/ac/structured-data/images/knowledge_graph_logo.png?201709101434","Banana" => "https://i5.walmartimages.ca/images/Enlarge/580/6_r/875806_R.jpg",
      "Carrot" => "https://images-na.ssl-images-amazon.com/images/I/51LH1PbgvDL._UX385_.jpg",
      "Dessert" =>"http://www.seriouseats.com/images/2017/07/20170717-no-bake-dessert-recipes-roundup-01.jpg"}[@lunkey]
  end
  def marogle
  end
  def marover
  end
  def vote
  end
  def result
    @res=params[:vote]
  end
  def random1

  end
  def resultrand
    @name=params[:text]
    @n=(1..9).to_a.sample(3)
    n2=(1..5).to_a.sample
    @make={1 => "덕력", 2 => "노안", 3 => "인기", 4 => "집중력", 5 => "뭔지 모르겠는데", 6 => "자상함", 7 => "허세", 8 => "똘끼", 9 => "귀찮음"}
    @make2={1 => "아주 조금", 2 => "조금", 3 => "보통",4 => "많이", 5 =>"아아아아아주 많이"}[n2]
  end
end
