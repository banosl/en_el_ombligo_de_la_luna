require './lib/linked_list.rb'
require './lib/node.rb'
require 'pry'

RSpec.describe LinkedList do
  before :each do
    @list = LinkedList.new
  end

  it 'a list is initiated with a head valued with nil' do
    expect(@list).to be_instance_of(LinkedList)
    expect(@list.head).to eq(nil)
  end

  context 'iteration 1' do
    before :each do
      @list.append("doop")
    end

    describe '#append' do
      it 'adds a new piece of data to the list' do
        expect(@list.head.data).to eq("doop")
        expect(@list.head.next_node).to eq(nil)
      end

      it 'adds a second piece of data to the list' do
        @list.append("deep")

        expect(@list.head.next_node).to be_instance_of(Node)
        expect(@list.head.next_node.data).to eq("deep")
      end
    end

    describe '#count' do
      it 'tells us how many things are in the list' do
        expect(@list.count).to eq(1)

        @list.append("deep")
        expect(@list.count).to eq(2)

        @list.append("boop")
        expect(@list.count).to eq(3)
      end
    end

    describe '#to_string' do
      it 'generates a string of all elements in the list, separated by spaces' do
        expect(@list.to_string).to eq("doop")

        @list.append("deep")
        expect(@list.to_string).to eq("doop deep")

        @list.append("boop")
        expect(@list.to_string).to eq("doop deep boop")
      end
    end
  end

  context 'iteration2' do
    before :each do
      @list.append("plop")
      @list.append("suu")
    end
    describe '#prepend' do
      it 'can add a node to the beginning of the list' do
        expect(@list.to_string).to eq("plop suu")
        expect(@list.count).to eq(2)

        @list.prepend("dop")

        expect(@list.to_string).to eq("dop plop suu")
        expect(@list.count).to eq(3)
      end
    end

    describe '#insert' do
      it 'can add a node at a specified position' do
        @list.prepend("dop")
        @list.insert(1, "woo")

        expect(@list.to_string).to eq("dop woo plop suu")

        @list.insert(3, "pip")

        expect(@list.to_string).to eq("dop woo plop pip suu")
      end
    end

    describe '#find' do
      it 'finds the node at a given position and returns the next n nodes in a string' do
        @list.append("deep")
        @list.append("woo")
        @list.append("shi")
        @list.append("shu")

        expect(@list.to_string).to eq("plop suu deep woo shi shu")
        expect(@list.find(2,1)).to eq("deep")
        expect(@list.find(1,3)).to eq("suu deep woo")
      end
    end

    describe '#includes?' do
      it 'returns true or false if the sound is in the list' do
        @list.append("deep")
        @list.append("woo")
        @list.append("shi")
        @list.append("shu")

        expect(@list.to_string).to eq("plop suu deep woo shi shu")
        expect(@list.include?("deep")).to be(true)
        expect(@list.include?("dep")).to be(false)
        expect(@list.include?("shu")).to be(true)
      end
    end

    describe '#pop' do
      it 'removes the last sound in the list' do
        @list.append("deep")
        @list.append("woo")
        @list.append("shi")
        @list.append("shu")

        expect(@list.to_string).to eq("plop suu deep woo shi shu")

        @list.pop
        expect(@list.to_string).to eq("plop suu deep woo shi")

        @list.pop
        expect(@list.to_string).to eq("plop suu deep woo")
        
        @list.pop
        expect(@list.to_string).to eq("plop suu deep")
      end
    end
  end
end