require 'rails_helper'

RSpec.describe ProxyObject do
  class RealObject
    def func1
      1
    end

    def func2 
      2
    end
  end

  class MyProxy < ProxyObject
    def func2
      2.2
    end
  end

  let(:real_object) { RealObject.new }
  let(:proxy_object) { MyProxy.new real_object }

  it 'should proxy to original method' do
    expect(proxy_object.func1).to eq 1
  end

  it 'should call overriden version of method' do
    expect(proxy_object.func2).to eq 2.2
  end

  it 'should raise NoMethod when undefined method is called' do
    expect do
      proxy_object.foo
    end.to raise_error(NoMethodError)
  end
end
