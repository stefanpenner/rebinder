# -*- coding: utf-8 -*-

class Method
  def rebind(*args,&block)
    unbind.bind(*args,&block)
  end
  alias ✈ rebind
end

class UnboundMethod
  def to_proc
    proc { |obj| self.bind(obj).call }
  end 

  def apply(obj)
    bind(obj).call
  end
  alias ☏ apply
end 

class Module

  class BadIdeaProxy < BasicObject

    def initialize(obj)
      @obj = obj
    end

    def method_missing(s)
      @obj.instance_method(s)
    end

  end

  def snowman(arg=nil)
    return instance_method(arg) if arg
    BadIdeaProxy.new(self)
  end

  alias ☃ snowman

end

# id = Object.☃.object_id
#  #=> #<UnboundMethod: Object(Kernel)#object_id>
#  
# [:omg, :wtf, :lol].map(&id)
#  #=> [507368, 507528, 507688] 
#
# id.☏ :lmao
#  #=> 507048
#
# add = 5.method(:+)
#
# [1,2,3].map(&add)
# #=> [6,7,8]
#
# [1,2,3].map(&add.✈ 10)
# #=> [11,12,13]

