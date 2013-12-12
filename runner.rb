require 'optparse'
require 'ostruct'
require './classes/cmd_runner'
require 'rubygems'
require 'net/ssh'
require 'net/scp'

options = OpenStruct.new

params = {
  platform:          %w(-t, --platform PLATFORM, kind of OS type(windows/linux)),
  ip_address:        %w(-i, --ip_address IP_ADDRESS, remote instance's ip address),
  login:             %w(-u, --username USERNAME, login),
  password:          %w(-p, --password PASSWORD, password),
  domain:            %w(-d, --domain DOMAIN, domain),
  acceptance_file:   %w(-a, --acceptance_criteria ACCEPTANCE_CRITERIA, acceptance criteria filepath)
}

optparse = OptionParser.new do |opts|
  params.each do |param, description|
    opts.on(*description) { |opt| options.public_send("#{param}=", opt) }
  end
end

optparse.parse!

dir = options.platform == 'windows' ? 'C:\temp' : '~/temp'

# Net::SSH::start(options.ip_address, options.login, password: options.password) do |ssh|
#   output = ssh.exec!(options.ip_address)
#   stdout = ""
#   ssh.exec!("mkdir #{dir}; mkdir #{dir}/vendor") #{ |channel, stream, data| stdout << data }
#   ssh.scp.upload! "Gemfile", "/home/#{options.login}/temp"
#   ssh.exec!("cd #{dir}; source ~/.zshrc; bundle install --path vendor") { |channel, stream, data| stdout << data }
#   puts stdout
# end

# %x( scp -r ../command_line_tool #{options.login}@#{options.ip_address}:/home/#{options.login}/temp )
runner = CmdRunner.new(options)
runner.run("ruby -v")
