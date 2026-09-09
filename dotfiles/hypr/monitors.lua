--Samsung
hl.monitor({
    output   = "desc:Samsung Electric Company LC27G7xT H4ZT400384",
    mode     = "2560x1440@239.96",
    position = "0x0",
    scale    = 1,
    vrr = 1,
    bitdepth = 10,
})

--Acer
hl.monitor({
    output   = "desc:Acer Technologies Acer XB241H #ASMZPaMPfFDd",
    mode     = "1920x1080@143.98",
    position = "-1080x-300",
    scale    = 1,
    transform = 1,
    vrr = 1,
})

--LG
hl.monitor({
    output   = "desc:LG Electronics LG TV 0x01010101",
    mode     = "1920x1080@60",
    position = "-3000x-600",
    scale    = 1,
})

--Catch-all
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = 1,
})
