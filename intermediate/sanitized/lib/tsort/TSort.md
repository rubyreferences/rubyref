# TSort

TSort implements topological sorting using Tarjan's algorithm for strongly
connected components.

TSort is designed to be able to be used with any object which can be
interpreted as a directed graph.

TSort requires two methods to interpret an object as a graph, tsort_each_node
and tsort_each_child.

*   tsort_each_node is used to iterate for all nodes over a graph.
*   tsort_each_child is used to iterate for child nodes of a given node.


The equality of nodes are defined by eql? and hash since TSort uses Hash
internally.

## A Simple Example

The following example demonstrates how to mix the TSort module into an
existing class (in this case, Hash). Here, we're treating each key in the hash
as a node in the graph, and so we simply alias the required `#tsort_each_node`
method to Hash's `#each_key` method. For each key in the hash, the associated
value is an array of the node's child nodes. This choice in turn leads to our
implementation of the required `#tsort_each_child` method, which fetches the
array of child nodes and then iterates over that array using the user-supplied
block.

    require 'tsort'

    class Hash
      include TSort
      alias tsort_each_node each_key
      def tsort_each_child(node, &block)
        fetch(node).each(&block)
      end
    end

    {1=>[2, 3], 2=>[3], 3=>[], 4=>[]}.tsort
    #=> [3, 2, 1, 4]

    {1=>[2], 2=>[3, 4], 3=>[2], 4=>[]}.strongly_connected_components
    #=> [[4], [2, 3], [1]]

## A More Realistic Example

A very simple `make` like tool can be implemented as follows:

    require 'tsort'

    class Make
      def initialize
        @dep = {}
        @dep.default = []
      end

      def rule(outputs, inputs=[], &block)
        triple = [outputs, inputs, block]
        outputs.each {|f| @dep[f] = [triple]}
        @dep[triple] = inputs
      end

      def build(target)
        each_strongly_connected_component_from(target) {|ns|
          if ns.length != 1
            fs = ns.delete_if {|n| Array === n}
            raise TSort::Cyclic.new("cyclic dependencies: #{fs.join ', '}")
          end
          n = ns.first
          if Array === n
            outputs, inputs, block = n
            inputs_time = inputs.map {|f| File.mtime f}.max
            begin
              outputs_time = outputs.map {|f| File.mtime f}.min
            rescue Errno::ENOENT
              outputs_time = nil
            end
            if outputs_time == nil ||
               inputs_time != nil && outputs_time <= inputs_time
              sleep 1 if inputs_time != nil && inputs_time.to_i == Time.now.to_i
              block.call
            end
          end
        }
      end

      def tsort_each_child(node, &block)
        @dep[node].each(&block)
      end
      include TSort
    end

    def command(arg)
      print arg, "\n"
      system arg
    end

    m = Make.new
    m.rule(%w[t1]) { command 'date > t1' }
    m.rule(%w[t2]) { command 'date > t2' }
    m.rule(%w[t3]) { command 'date > t3' }
    m.rule(%w[t4], %w[t1 t3]) { command 'cat t1 t3 > t4' }
    m.rule(%w[t5], %w[t4 t2]) { command 'cat t4 t2 > t5' }
    m.build('t5')

## Bugs

*   'tsort.rb' is wrong name because this library uses Tarjan's algorithm for
    strongly connected components. Although 'strongly_connected_components.rb'
    is correct but too long.


## References

    1.  Tarjan, "Depth First Search and Linear Graph Algorithms",


*SIAM Journal on Computing*, Vol. 1, No. 2, pp. 146-160, June 1972.

[TSort Reference](https://ruby-doc.org/stdlib-2.5.0/libdoc/tsort/rdoc/TSort.html)