class Method
  def rebind(*args,&block)
    unbind.bind(*args,&block)
  end
end
