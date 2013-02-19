require 'kusakabe'

module Guideline
  class KusakabeChecker < Checker
    def check(path)
      path.each_line.with_index do |line, index|
        begin
          Kusakabe.validate(line)
        rescue => e
          report(
            :line    => index + 1,
            :path    => path,
            :message => e.message
            )
        end
      end
    end
  end
end
