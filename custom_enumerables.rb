# Add custom methods onto the existing Enumerable module
module Enumerable
    # arrays used for testing
    numbers = [1, 2, 3, 4, 5]
    items = ["Pencil", "Pencil", "Eraser", "Calculator", "Notebook", "Computer"]

    # each
    def my_each
        i = 0
        while i < length
            item = self[i]
            yield item
            i += 1
        end
    end

    # each comparison 
    #numbers.my_each {|item| puts item}
    #numbers.each {|item| puts item}

    # each_with_index
    def my_each_with_index
        i = 0
        while i < length
            item = self[i]
            index = i
            yield item, index
            i += 1
        end
    end

    # each_with_index comparison
    #items.my_each_with_index { |item, index| puts "#{item} at #{index}" }
    #items.each_with_index { |item, index| puts "#{item} at #{index}" }

    # select
    def my_select
        output = []
        self.my_each do |item|
            output.push(item)
        end
        yield output
    end

    # select comparison
    #items.my_select { |item| puts item }
    #items.select { |item| puts item }

    # all?
    def my_all?(&block)
        my_each(&block)
    end
        

    # all? comparison
    #items.my_all? { |item| puts item.length > 3}
    #items.all? { |item| puts item.length > 3}

    # any? 
    def my_any?
        my_each do |item|
            return true if yield(item)
        end
        false
    end

    # any? comparison
    #puts items.my_any? { |item| item == "Pencil"}
    #puts items.any? { |item| item == "Pencil"}
        
    # none?
    def my_none?
        my_each do |item|
            return false if yield(item)
        end
        true
    end

    # none? comparison
    #puts items.my_none? { |item| item == "Backpack"}
    #puts items.none? { |item| item == "Pencil"}

    # count
    def my_count(counted_item)
        count = 0
        my_each do |item|
            if item == counted_item
                count += 1
            end
        end
        return count
    end

    # count comparison
    #puts items.my_count("Pencil")
    #puts items.count("Pencil")

    # map 
    def my_map(block = nil)
        output = []
        my_each do |item|
            if block.nil?
                output.push(yield(item))
            else
                output.push(block.call(item))
            end
        end
        return output
    end

    # map comparison
    #puts items.my_map { |item| item.upcase }
    #puts items.map { |item| item.upcase }

    # with proc
    #a_proc = Proc.new { |item| item + "!" }
    #puts items.my_map(a_proc)

    # inject
    def my_inject(&block)
        accumulator = self[0]
        my_each_with_index do |item, index|
            next if index == 0
            accumulator = block.call(accumulator, item)
        end
        return accumulator
    end

    # inject comparison
    #puts numbers.my_inject { |sum, number| sum + number}
    #puts numbers.inject { |sum, number| sum + number }
end

# test inject with a method that multiplies elements
def multiply_els(arr)
    return arr.my_inject { |product, num| product * num}
end

puts multiply_els([1, 2, 3, 4, 5])
