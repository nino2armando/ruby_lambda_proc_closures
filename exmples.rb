#-----------------------------
# block example
#-----------------------------

arr = [1,2,3,4,5,6]

arr.each do |num|
  puts num.to_s
end

arr.each {|num| puts num.to_s}

def run_block
  yield # yield looks for a block being passed
end

run_block do
  puts "hello world"
end

def run_block_with_check
  yield if block_given?
end

run_block_with_check do
  puts "hello world"
end

def run_block_with_arg(&a)
  a.call
end

run_block_with_arg  do
  puts "hi"
end


#-----------------------------
# proc example
#-----------------------------

class Array
  def random_each
    shuffle.each do |num|
      yield num
    end
  end
end


arr.random_each do |n|
  puts n
end

class Array
  def random_each_with_block(&b)
    shuffle.each do |num|
      b.call num
    end
  end
end

arr.random_each_with_block do |n|
  puts n
end


# more proc

def run_procs(a, b)
  a.call
  b.call
end

proc1 = Proc.new do
  puts "proc1"
end

proc2 = Proc.new{puts "proc2"}

run_procs proc1, proc2

# we can also call proc without param

def run_proc_no_param
  p = Proc.new
  p.call
end

run_proc_no_param do
  puts "some proc"
end

# some of the ways to call a proc

my_proc = Proc.new do |n|
  puts n
end

my_proc.call(10)
my_proc.(10)
my_proc[10]
my_proc === 10

#-----------------------------
# lambda example
#-----------------------------

my_lambda = lambda do
  puts "this is a lambda"
end
my_lambda.call


# lambdas expect the correct argument as they do check

my_lambda_with_param = lambda do |a,b|
  puts "#{a} , #{b} passed as args"
end

my_lambda_with_param.call(1,2) # this is good
#my_lambda_with_param.call # this will blow up since no args are being passed


# lambdas also have return semantics

def run_proc_or_lambda(a)
  puts "start"
  a.call
  puts "end"
end

run_proc_or_lambda lambda{puts "passed lambda"; return}

# run_proc_or_lambda Proc.new{puts "passed proc"; return} # this will cause an error since it is trying to return from the main context
# and that is not possible where as the example above(lambda) returns from
# the context of the method not the main context

# to fix the above issue with proc we can do something like this

def call_both_lambda_proc
  run_proc_or_lambda lambda{puts "passed lambda"; return}
  run_proc_or_lambda Proc.new{puts "passed proc"; return} # now this ok since it is returning for the scope of method
  # which indicates the return semantic of lambdas vs procs
end

call_both_lambda_proc

# by switching the order of the lambda and proc we can see the difference from above

def call_both_proc_lambda
  run_proc_or_lambda Proc.new{puts "passed proc"; return}
  run_proc_or_lambda lambda{puts "passed lambda"; return}
end

call_both_proc_lambda


#-----------------------------
# closures example
#-----------------------------


def run_proc_for_closure(p)
  p.call
end

name= "nino"
print_name = Proc.new{puts name}

run_proc_for_closure print_name # although run_proc_for_closure know nothing about the name variable still executes it

# this example shows how closures are keeping the reference of the variable rather than variable


name2 = "nino2"

print_name = Proc.new{puts name2}

name2 = "n"

run_proc_for_closure print_name

# more closure examples

def multiplier(n)
  lambda do |m|
    n * m
  end
end

doubler = multiplier(2)
tripler = multiplier(3)


puts doubler.call(5)
puts tripler.call(10)


