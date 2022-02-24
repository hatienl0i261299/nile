# frozen_string_literal: true

class TestClass
  attr_reader :test

  def initialize
    @test = '123'
  end
end

temp = TestClass.new
p temp.test
