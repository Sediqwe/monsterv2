module NewsHelper
    def random_color
        color = ["red","blue","green", "yellow","warning", "primary" , "orange", "pink", "violet" , "grey", "danger"]
        num = rand(0..color.length-1)
        p color[num]
    
      end
      def random_icon
        color = ["award","align-justify","angle-double-right", "balance-scale","biohazard", "bomb" , "bone", "bolt", "bullhorn" , "carrot", "chart-bar"]
        num = rand(0..color.length-1)
        p color[num]
    
      end
end
