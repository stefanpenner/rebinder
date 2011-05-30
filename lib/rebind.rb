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

  def ☃
    BadIdeaProxy.new(self)
  end 

end 

# id = Object.☃.object_id
#  #=> #<UnboundMethod: Object(Kernel)#object_id>
#  
# [:omg, :wtf, :lol].map(&id)
#  #=> [507368, 507528, 507688] 
#
# id.☏ :lmao
#  #=> 507048
