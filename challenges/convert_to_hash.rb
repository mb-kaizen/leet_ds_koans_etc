# Convert the following string format into hash, object, or dictionary:

# "a.b.c.d=5&a.b.c.e=6&f.g=7"
# {a: {b: {c: {d:5, e:6}}}, f:{g:7}}


# Test Cases:

# convert("a.b.c=1&a.b.d=2") => {a:{b:{c:1, d:2}}
# convert("a.b.c.d=1&a.e=2&b.a=3&a.b.g=4") => {a: {b:{c:{d:1}, g: 4}, e: 2}, b:{a:3}}
# convert("a.b=5") => {a: {b:5}}

def insert_nested(path, value, data)
    # Inserts a value into a hash located at a nested path

    # data = {}
    # insert_nested(['a', 'b', 'c'], 1, data)
    # would yield a 'data' of:
    # {
    #     'a' => {
    #         'b' => {
    #             'c' => 1
    #         }
    #     }
    # }
    key, remaining_path =  path[0], path.drop(1)

    if remaining_path.empty?
        data[key] = value
    else
        data[key] = {} unless data.has_key?(key)
        insert_nested(remaining_path, value, data[key])
    end
end

def parse_query(query)
    # Given an HTTP query string (without '?'), create hash with parameters
    data = {}

    for key_value in query.split('&')
        key, value = key_value.split('=')
        insert_nested(key.split('.'), value, data)
    end

    return data
end

tests = [
    "a.b.c=1&a.b.d=2",
    "a.b.c.d=1&a.e=2&b.a=3&a.b.g=4",
    "a.b=5"     
]

for test in tests
    print "#{test}\nmakes: #{parse_query(test)}\n\n"
end