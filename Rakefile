# Inspired by https://github.com/holman/dotfiles and https://github.com/skwp/dotfiles

require 'rake'

desc "Hook our dotfiles into system-standard positions."
task :install do
  skip_all = false
  overwrite_all = false
  backup_all = false

  linkables.each do |linkable|
    overwrite = false
    backup = false

    file = convert(linkable)
    source = "#{ENV["PWD"]}/#{linkable}"
    target = "#{ENV["HOME"]}/#{file}"

    if File.exists?(target) || File.symlink?(target)
      unless skip_all || overwrite_all || backup_all
        puts "File already exists: #{target}, what do you want to do? [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all"
        case STDIN.gets.chomp
        when 'o' then overwrite = true
        when 'b' then backup = true
        when 'O' then overwrite_all = true
        when 'B' then backup_all = true
        when 'S' then skip_all = true
        when 's' then next
        end
      end
      run %{ rm "#{target}" } if overwrite || overwrite_all
      run %{ mv "$HOME/#{file}" "$HOME/#{file}.dotfile-backup" } if backup || backup_all
    end
    run %{ ln -s "#{source}" "#{target}" }
  end
end

desc "Uninstall our dotfiles."
task :uninstall do
  linkables.each do |linkable|
    file = convert(linkable)
    target = "#{ENV["HOME"]}/#{file}"

    # Remove all symlinks created during installation
    if File.symlink?(target)
      run %{ rm "#{target}" }
    end

    # Replace any backups made during installation
    if File.exists?("#{ENV["HOME"]}/#{file}.dotfile-backup")
      run %{ mv "$HOME/#{file}.dotfile-backup" "$HOME/#{file}" }
    end
  end
end

task :default => 'install'


private

def run(cmd)
  puts
  puts "[Installing] #{cmd}"
  `#{cmd}` unless ENV['DEBUG']
end

def convert(linkable)
  elems = linkable.split('/')
  return elems[1..elems.size].join('/').chomp('.symlink')
end

def linkables
  return Dir.glob('**/*{.symlink}', File::FNM_DOTMATCH)
end
