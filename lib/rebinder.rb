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
    def setup
      @id = Object.☃.object_id
    end 

    def test_☃
      assert_equal "#<UnboundMethod: Object(Kernel)#object_id>", @id.inspect
      assert_equal [3,5,7], [1,2,3].map(&@id)
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
    
  end 
end 

# add = 5.method(:+)
#
# [1,2,3].map(&add)
# #=> [6,7,8]
#
# [1,2,3].map(&add.✈ 10)
# #=> [11,12,13]

