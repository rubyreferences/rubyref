# SDBM

SDBM provides a simple file-based key-value store, which can only store String
keys and values.

Note that Ruby comes with the source code for SDBM, while the DBM and GDBM
standard libraries rely on external libraries and headers.

### Examples

Insert values:

    require 'sdbm'

    SDBM.open 'my_database' do |db|
      db['apple'] = 'fruit'
      db['pear'] = 'fruit'
      db['carrot'] = 'vegetable'
      db['tomato'] = 'vegetable'
    end

Bulk update:

    require 'sdbm'

    SDBM.open 'my_database' do |db|
      db.update('peach' => 'fruit', 'tomato' => 'fruit')
    end

Retrieve values:

    require 'sdbm'

    SDBM.open 'my_database' do |db|
      db.each do |key, value|
        puts "Key: #{key}, Value: #{value}"
      end
    end

Outputs:

    Key: apple, Value: fruit
    Key: pear, Value: fruit
    Key: carrot, Value: vegetable
    Key: peach, Value: fruit
    Key: tomato, Value: fruit

[SDBM Reference](https://ruby-doc.org/stdlib-2.5.0/libdoc/sdbm/rdoc/SDBM.html)