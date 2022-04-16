import cpp

from Macro m
where m.getName() in ["ntohs", "ntohl", "ntoll"]
select m, "ntoh* macros"

