class CmdRunner

  def initialize(options)
    # winexe -U HOME/Administrator%Pass123 //192.168.0.10 "ipconfig /all"
    @cmd = case options.platform
    when "windows"
      "winexe -U #{options.login}%#{options.password} //#{options.ip_address}"
    else
      "ssh #{options.login}@#{options.ip_address}"
    end

    p @cmd
  end

  def run(command)
    cmd = "#{@cmd} '#{command}'"
    p %x( #{cmd} )
  end

end #class CmdRunner
