# frozen_string_literal: true

module DeepCover
  require_relative '../../deep_cover'
  bootstrap
  require_relative 'helpers'

  module CLI
    class Clear
      def self.from_argv(argv = ARGV)
        begin
          parse_result = parse_options.parse(argv)
        rescue Slop::UnknownOption => e
          abort e.message
        end

        if !parse_result.arguments.empty?
          abort "Unexpected argument: #{parse_result.arguments.first.inspect}"
        end

        new(**parse_result.to_h.slice(:output))
      end

      def self.parse_options
        @parse_options ||= Slop::Options.new do |o|
          o = CLI::Helpers::AddDefaultToOptionsDescription.new(o)
          o.banner = ['usage: deep-cover clear [options]',
                      '   or  deep-cover clean [options]',
          ].join("\n")
          o.separator ''
          o.string '-o', '--output', 'output folder', default: DEFAULTS[:output]

          o.boolean('-h', '--help') do
            puts parse_options
            exit
          end
        end
      end

      def initialize(output: DEFAULTS[:output])
        @output = Pathname(output)
      end

      def go
        @output.rmtree if @output.exist?
      end
    end
  end
end
