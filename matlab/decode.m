function m=decode(c, G)
for i=0:31
    if encode(binary_lookup(i), G) == c
        m=binary_lookup(i);
        return;
    end
end
end