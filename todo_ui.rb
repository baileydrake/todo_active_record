require 'active_record'
require './lib/task'

database_configuration = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configuration['development']
ActiveRecord::Base.establish_connection(development_configuration)


def welcome
  puts "Bienvenidos"
  menu
end


def menu
  choice = nil
  until choice == 'e'
    puts 'a: add task, l: list tasks, d: mark done, e: exit'
    choice = gets.chomp
    case choice
    when 'a'
      add
    when 'l'
      list
    when 'd'
      mark_done
    when 'e'
      puts "good bye"
    else
      puts "invalid choice"
    end
  end
end

def add
  puts "what do you want to do?"
  task_name = gets.chomp
  task = Task.new(:name => task_name, :done => false)
  task.save
end

def list
  tasks = Task.not_done
  tasks.each {|task| puts task.name}
end

def mark_done
  list
  puts "which task do you want to mark as done?"
  task_choice = gets.chomp
  done_task = Task.where(:name => task_choice).pop
  done_task.update_attributes(:done => true)
end

welcome
