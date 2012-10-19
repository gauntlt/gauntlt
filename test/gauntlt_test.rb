require 'test_helper'

subject = Gauntlt

# .attacks
# "returns the names of all attack files in the attacks directory"
lambda do
  stub(subject, :method => :attack_adapters, :return => ['/x/y/a.rb','/x/y/b.rb']) do
    assert subject.attacks, :== => ['a', 'b']
  end
end.call

# .attack_adapters
# "returns the full path to each attack adapter"
lambda do
  const_stub(Gauntlt, :name => :ATTACK_ADAPTERS_GLOB_PATTERN, :value => 'foo') do
    stub(Dir, :method => :glob, :return => ['bar', 'baz']) do
      assert subject.attack_adapters, :== => ['bar', 'baz']
    end
  end
end.call

# .attack
# "runs the specified test with the passed options"
lambda do
  mock_attack = Object.new
  stub(subject::Attack, :spy => :new, :return => mock_attack) do
    stub(mock_attack, :spy => :run) do
      subject.attack(:foo)
    end
  end
end.call