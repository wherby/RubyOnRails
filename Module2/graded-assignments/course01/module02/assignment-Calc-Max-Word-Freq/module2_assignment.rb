#Implement all parts of this assignment within (this) module2_assignment2.rb file

#Implement a class called LineAnalyzer.
class LineAnalyzer
  #Implement the following read-only attributes in the LineAnalyzer class. 
  #* highest_wf_count - a number with maximum number of occurrences for a single word (calculated)
  #* highest_wf_words - an array of words with the maximum number of occurrences (calculated)
  #* content,         - the string analyzed (provided)
  #* line_number      - the line number analyzed (provided)
  attr_reader :highest_wf_count, :highest_wf_words, :content, :line_number

  #Add the following methods in the LineAnalyzer class.
  #* initialize() - taking a line of text (content) and a line number
  #* calculate_word_frequency() - calculates result
  def initialize(content, line_num)
    @content = content
    @line_number = line_num
    calculate_word_frequency(content)
  end

  def calculate_word_frequency(content)
    word_frequency = Hash.new(0)
    content.split.each do |word|
      word_frequency[word.downcase] += 1
    end
    max_count = 0
    max_value = []
    word_frequency.each_pair do |key, value|
      if value > max_count
        max_count = value
      end
    end
    @highest_wf_words = word_frequency.select{|key,value| value == max_count}.keys
    @highest_wf_count = max_count
  end

  #Implement the initialize() method to:
  #* take in a line of text and line number
  #* initialize the content and line_number attributes
  #* call the calculate_word_frequency() method.

  #Implement the calculate_word_frequency() method to:
  #* calculate the maximum number of times a single word appears within
  #  provided content and store that in the highest_wf_count attribute.
  #* identify the words that were used the maximum number of times and
  #  store that in the highest_wf_words attribute.
end

#  Implement a class called Solution. 
class Solution

  # Implement the following read-only attributes in the Solution class.
  #* highest_count_across_lines - a number with the value of the highest frequency of a word
  #* highest_count_words_across_lines - an array with the words with the highest frequency
  attr_reader :highest_count_across_lines, :highest_count_words_across_lines, :analyzers

  def initialize()
    @analyzers = []
  end
  
  # Implement the following methods in the Solution class.
  #* analyze_file() - processes 'test.txt' intro an array of LineAnalyzers
  #* calculate_line_with_highest_frequency() - determines which line of
  #text has the highest number of occurrence of a single word
  #* print_highest_word_frequency_across_lines() - prints the words with the 
  #highest number of occurrences and their count
  def analyze_file()
    line_num = 1
    File.foreach('test.txt') do |line|
      temp_any = LineAnalyzer.new(line, line_num)
      line_num += 1
      @analyzers.push(temp_any)
    end
    @analyzers
  end

  def calculate_line_with_highest_frequency()
    max = 0
    max_value = []
    @highest_count_words_across_lines = []
    @analyzers.each do |any|
      if any.highest_wf_count > max
        max = any.highest_wf_count
        max_value = any.highest_wf_words
      end
    end
    @highest_count_across_lines = max

    max_value = @analyzers.select{|any| any.highest_wf_count == max}
    @highest_count_words_across_lines = max_value
  end

  def print_highest_word_frequency_across_lines()
    puts "The following words have the highest word frequency per line:"
    @highest_count_words_across_lines.each do |any|
      puts any.highest_wf_words "appears in line #{any.line_number}"
    end
  end

  
  # Implement the analyze_file() method() to:
  #* Read the 'test.txt' file in lines 
  #* Create an array of LineAnalyzers for each line in the file

  # Implement the calculate_line_with_highest_frequency() method to:
  #* calculate the highest number of occurences of a word across all lines
  #and stores this result in the highest_count_across_lines attribute.
  #* identifies the words that were used with the highest number of occurrences
  #and stores them in print_highest_word_frequency_across_lines.

  #Implement the print_highest_word_frequency_across_lines() method to
  #* print the result in the following format
end
