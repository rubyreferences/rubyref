# PStore

PStore implements a file based persistence mechanism based on a Hash.  User
code can store hierarchies of Ruby objects (values) into the data store file
by name (keys).  An object hierarchy may be just a single object.  User code
may later read values back from the data store or even update data, as needed.

The transactional behavior ensures that any changes succeed or fail together.
This can be used to ensure that the data store is not left in a transitory
state, where some values were updated but others were not.

Behind the scenes, Ruby objects are stored to the data store file with
Marshal.  That carries the usual limitations.  Proc objects cannot be
marshalled, for example.

## Usage example:

    require "pstore"

    # a mock wiki object...
    class WikiPage
      def initialize( page_name, author, contents )
        @page_name = page_name
        @revisions = Array.new

        add_revision(author, contents)
      end

      attr_reader :page_name

      def add_revision( author, contents )
        @revisions << { :created  => Time.now,
                        :author   => author,
                        :contents => contents }
      end

      def wiki_page_references
        [@page_name] + @revisions.last[:contents].scan(/\b(?:[A-Z]+[a-z]+){2,}/)
      end

      # ...
    end

    # create a new page...
    home_page = WikiPage.new( "HomePage", "James Edward Gray II",
                              "A page about the JoysOfDocumentation..." )

    # then we want to update page data and the index together, or not at all...
    wiki = PStore.new("wiki_pages.pstore")
    wiki.transaction do  # begin transaction; do all of this or none of it
      # store page...
      wiki[home_page.page_name] = home_page
      # ensure that an index has been created...
      wiki[:wiki_index] ||= Array.new
      # update wiki index...
      wiki[:wiki_index].push(*home_page.wiki_page_references)
    end                   # commit changes to wiki data store file

    ### Some time later... ###

    # read wiki data...
    wiki.transaction(true) do  # begin read-only transaction, no changes allowed
      wiki.roots.each do |data_root_name|
        p data_root_name
        p wiki[data_root_name]
      end
    end

## Transaction modes

By default, file integrity is only ensured as long as the operating system
(and the underlying hardware) doesn't raise any unexpected I/O errors. If an
I/O error occurs while PStore is writing to its file, then the file will
become corrupted.

You can prevent this by setting *pstore.ultra_safe = true*. However, this
results in a minor performance loss, and only works on platforms that support
atomic file renames. Please consult the documentation for `ultra_safe` for
details.

Needless to say, if you're storing valuable data with PStore, then you should
backup the PStore files from time to time.