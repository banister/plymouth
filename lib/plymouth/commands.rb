module Plymouth
  Commands = Pry::CommandSet.new do
    create_command "plymouth-off", "Disable Plymouth." do
      banner <<-BANNER
        Usage: plymouth-off
        Exit the REPL and turn Plymouth off for the duration of the test suite.
      BANNER

      def process
        Plymouth.disable!

        # exit the REPL
        run "exit-all"
      end
    end

    create_command "plymouth-on", "Enable Plymouth." do
      banner <<-BANNER
        Usage: plymouth-off
        Enable Plymouth.
      BANNER

      def process
        Plymouth.enable!
      end
    end
  end
end
