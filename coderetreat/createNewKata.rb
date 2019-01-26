#!/usr/bin/ruby
require "optparse"
require "fileutils"

ValidLanguagesKeys = [:java, :c, :python, :ruby]
DirectorySuffix = "Practice"
TestFilePrefix = "run"
TestFileSuffix = "Test.sh"
GameOfLifePattern = "gameOfLife"

class CreateKataOptionParser
  def self.parse(args)
    options = {}
    options[:className] = "foo"
    opt_parser = OptionParser.new do |opts|
      opts.banner = "Usage: ruby createNewKata.rb [options]"
      opts.separator ""
      opts.separator "options:"

      opts.on("-l", "--language LANGUAGE", ValidLanguagesKeys,
              "the language of your choice : ",
              " " + ValidLanguagesKeys
        .to_s) do |language|
        options[:language] = language
      end

      opts.on("-n", "--name NAME", "the name of your first class") do |className|
        options[:className] = className
      end

      opts.on("-v", "--verbose", "prints debug info") do |verbose|
        options[:verbose] = verbose
      end

      opts.on_tail("-h", "--help", "Show this message") do
        puts opts
        exit
      end
    end
    begin
      opt_parser.parse!(args)
      raise OptionParser::MissingArgument.new("-l") if options[:language].nil?
    rescue OptionParser::InvalidArgument, OptionParser::MissingArgument => exception
      puts "\n" + exception.to_s + "\n"
      puts opt_parser
      exit
    end
    options
  end
end

options = CreateKataOptionParser.parse(ARGV)
sourceDir = options[:language].to_s + DirectorySuffix
destinationDir = options[:language].to_s + options[:className].capitalize + DirectorySuffix
puts "Copying " + sourceDir + " to " + destinationDir if options[:verbose]
FileUtils.copy_entry(sourceDir, destinationDir)
Dir.glob(destinationDir + "/**/*").each do |fileName|
  next unless fileName =~ /#{GameOfLifePattern}/i
  newFileName = fileName.sub(/#{GameOfLifePattern}/i, options[:className])
  FileUtils.mv(fileName, newFileName, verbose: options[:verbose])
end

Dir.glob(destinationDir + "/**/*").each do |fileName|
  next unless File.file?(fileName)
  puts "replacing kata name #{options[:className]} in #{fileName}" if options[:verbose]
  fileText = File.read(fileName)
  updatedFileText = fileText.gsub(/#{GameOfLifePattern}/i, options[:className])
  updatedFileText = updatedFileText.gsub(sourceDir, destinationDir)
  File.open(fileName, "w") do |file|
    file.write(updatedFileText)
  end
end
FileUtils.chmod_R("u+rwx", destinationDir)

runFileSrc = TestFilePrefix + options[:language].to_s.capitalize
runFileSrc += TestFileSuffix
runFileDest = TestFilePrefix + options[:language].to_s.capitalize
runFileDest += options[:className].to_s + TestFileSuffix
puts "Copying " + runFileSrc + " to " + runFileDest if options[:verbose]
FileUtils.copy_entry(runFileSrc, runFileDest)
fileText = File.read(runFileDest)
updatedFileText = fileText.gsub(/#{GameOfLifePattern}/i, options[:className])
updatedFileText = updatedFileText.gsub(sourceDir, destinationDir)
File.open(runFileDest, "w") do |file|
  file.write(updatedFileText)
end
FileUtils.chmod("u+rwx", runFileDest)
