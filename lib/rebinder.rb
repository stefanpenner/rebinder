# -*- coding: utf-8 -*-

class Method
  def rebind(*args,&block)
    unbind.✈(*args,&block)
  end
  alias ✈ rebind
  alias ◊ call
end

class Proc
  alias ◊ call
end 

class UnboundMethod
  def to_proc
    proc { |obj| self.✈(obj).◊ }
  end 

  alias ✈ bind

  def apply(obj)
    ✈(obj).◊
  end
  alias ☏ apply

  def compose(meth2)
    meth1 = self
    meth1.owner.send(:define_method, :__composition) {
      meth2.✈(meth1.✈(self).◊).◊
    }
    ret = meth1.owner.instance_method(:__composition)
    meth1.owner.send :remove_method, :__composition
    ret
  end
  alias • compose

  def partial_application(arg)
    meth = self
    meth.owner.send(:define_method, :__curry) { |*args|
      meth.✈(self).◊(arg, *args)
    }
    ret = meth.owner.instance_method(:__curry)
    meth.owner.send :remove_method, :__curry
    ret
  end
  alias ∂ partial_application
  
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

if __FILE__ == $0
  require 'minitest/autorun'
  class OmgTest < MiniTest::Unit::TestCase

    def test_☃
      id = Object.☃.object_id
      assert_equal "#<UnboundMethod: Object(Kernel)#object_id>", id.inspect
      assert_equal [3,5,7], [1,2,3].map(&id)
    end

    def test_☏
      upcase = String.☃.upcase
      assert_equal "ZOMFG", upcase.☏("zomfg")
    end

    def test_•
      upcase  = String.☃.upcase
      reverse = String.☃.reverse
      reverse_upcase = reverse.•(upcase)
      assert_equal "OMG", reverse_upcase.☏("gmo")
    end 

    def test_✈
      add = 5.method(:+)
      assert_equal [6,7,8],    [1,2,3].map(&add)
      assert_equal [11,12,13], [1,2,3].map(&add.✈(10))
    end

    def test_∂
      add = Fixnum.☃.+
      add3 = add.∂(3)
      assert_equal 7, add3.☏(4)
    end 
    
  end 
end 


