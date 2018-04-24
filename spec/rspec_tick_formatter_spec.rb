$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require "rspec-tick-formatter"

# Just to demonstrate its output

describe RspecTickFormatter do
  context "test spec" do

    context "context 1" do
      it "works" do
        expect(1).to eq 1
      end

      pending "is pending"
    end

    context "context 2" do
      it "works too" do
        expect(1).to  eq 1
      end

      it "fails" do
        expect(1).to eq 42
      end
    end
  end
end
