# from http://missingbit.blogspot.com/2011/07/stubbing-constants-in-rspec_20.html
# example: (from http://digitaldumptruck.jotabout.com/?p=551)
#     it "does not allow links to be added in production environment" do
#       with_constants :RAILS_ENV => 'production' do
#         get :add, @nonexistent_link.url
#         response.should_not be_success
#       end
#     end
module RSpecConstantsHelpers
  def constantize(camel_cased_word)
    names = camel_cased_word.split('::')
    names.shift if names.empty? || names.first.empty?

    constant = Object
    names.each do |name|
      constant = constant.const_defined?(name) ? constant.const_get(name) : constant.const_missing(name)
    end
    constant
  end

  def parse(constant)
    source, _, constant_name = constant.to_s.rpartition('::')

    [constantize(source), constant_name]
  end

  def with_constants(constants, &block)
    saved_constants = {}
    constants.each do |constant, val|
      source_object, const_name = parse(constant)

      saved_constants[constant] = source_object.const_get(const_name)
      source_object.const_set(const_name, val)
    end

    begin
      block.call
    ensure
      constants.each do |constant, val|
        source_object, const_name = parse(constant)

        source_object.const_set(const_name, saved_constants[constant])
      end
    end
  end
end