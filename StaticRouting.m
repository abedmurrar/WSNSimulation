function n2 = StaticRouting(n,size)
    n = n.sendMessage(10, 9, size);
    n = n.sendMessage(9, 6, size);
    n = n.sendMessage(6, 18, size);
    n = n.sendMessage(18, 16, size);
    n = n.sendMessage(4, 16, size);
    n = n.sendMessage(16, 15, size);
    n = n.sendMessage(15, 2, size);
    n = n.sendMessage(2, 19, size);
    
    n = n.sendMessage(3, 14, size);
    n = n.sendMessage(14, 1, size);
    n = n.sendMessage(1, 19, size);
    
    n = n.sendMessage(8, 7, size);
    n = n.sendMessage(7, 5, size);
    n = n.sendMessage(5, 17, size);
    n = n.sendMessage(17, 2, size);
    
    n = n.sendMessage(11, 12, size);
    n = n.sendMessage(12, 13, size);
    n = n.sendMessage(13, 17, size);
    n2 = n;
end