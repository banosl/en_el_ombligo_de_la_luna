require 'pry'
require "./lib/node.rb"

RSpec.describe Node do
  it 'can make a node with data and next pointer' do
    node = Node.new("plop")

    expect(node.data).to eq("plop")
    expect(node.next_node).to eq(nil)
  end

  describe "#append" do
    it 'can add a node to next_node' do
      node = Node.new("plop")
      node.append("peep")

      expect(node.next_node).to be_instance_of(Node)
      expect(node.next_node.data).to eq("peep")
    end
  end

  describe "#remove_next_node" do
    it 'can reset next node to nil' do
      node = Node.new("plop")
      node.append("peep")

      expect(node.next_node.data).to eq("peep")
          
      node.remove_next_node
      expect(node.next_node).to eq(nil)
    end
  end
end