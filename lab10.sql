--Author: Phil Kirwin
--Lab 10
--12/1/16

--Immediate Prerequisites for a passed-in coursenumber
create or replace function PreReqsFor(int, REFCURSOR) returns refcursor as 
$$
declare
   courseNumber   int    := $1;
   resultset      REFCURSOR := $2;
begin
	open resultset for 
		SELECT num, name, credits
		FROM courses
		WHERE num IN (SELECT prereqnum
		    FROM prerequisites
		    WHERE coursenum = courseNumber
		);
	return resultset;
end;
$$ 
language plpgsql;

--Courses for which a passed-in course is an immediate prerequisite for
create or replace function IsPreReqsFor(int, REFCURSOR) returns refcursor as 
$$
declare
	courseNumber   int       := $1;
	resultset      REFCURSOR := $2;
begin
	open resultset for 
		SELECT num, name, credits
		FROM courses
		WHERE num IN (SELECT coursenum
			FROM prerequisites
		    WHERE prereqnum = courseNumber
		);
	return resultset;
end;
$$ 
language plpgsql;