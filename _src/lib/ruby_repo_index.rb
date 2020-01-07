require 'pathname'

class RubyRepoIndex
  attr_reader :repo

  using(Module.new do
    refine Pathname do
      def match?(pat)
        to_s.match?(pat)
      end
    end
  end)

  def initialize(path)
    @repo = Pathname.new(path)
  end

  memoize def doc_files
    repo.glob('doc/{,**/}*.rdoc').reject { _1.match?(/\.ja\./) }.uniq
  end

  memoize def core_files
    repo.glob('{,**/}*.c').reject { _1.match?(%r{/(ext|missing)/}) } +
      repo.glob('*.rb') # Since 2.7, some of modules (AND their main docs) are in rb
  end

  memoize def ext_files
    repo.glob('ext/*').reject { _1.match?(/-test-/) }.select(&:directory?)
    .sort.to_h { [_1.basename.to_s, _1] }
  end

  memoize def lib_files
    repo./('lib/.document').read.split("\n")
      .map { _1.sub(/\#.*$/, '').strip }.reject(&:empty?)
      .map { "lib/#{_1}" }
      .grep_v(%r{/net})
      .push('lib/net/{*,*.rb}') # net/* should be treated as separate libs
      .then(&repo.method(:glob))
      .group_by { libname(_1.to_s) } # group optparse.rb & optparse and so on
      .sort
      .to_h
  end

  private

  def libname(path)
    base = path.sub(repo./('lib').to_s, '')
    File.basename(path, '.rb')
      .then { |path| base.start_with?('/net/') ? "net/" + path : path }
  end
end