USE FUH_COMPANY

--Câu 1: Cho biết ai đang quản lý phòng ban có tên: Phòng Nghiên cứu và phát triển. Thông tin yêu cầu: mã số,họ tên nhân viên, mã số phòng ban, tên phòng ban
SELECT tblEmployee.empSSN, tblEmployee.empName,tblDepartment.depName, tblDepartment.depNum
FROM tblDepartment
INNER JOIN  tblEmployee
ON tblDepartment.depNum = tblEmployee.depNum
WHERE tblDepartment.depNum = 5

--Câu 2: Cho phòng ban có tên: Phòng Nghiên cứu và phát triển hiện đang quản lý dự án nào. Thông tin yêu cầu: mã số dụ án, tên dự án, tên phòng ban quản lý
SELECT tblProject.proNum, tblProject.proName, tblDepartment.depName
FROM tblDepartment
INNER JOIN tblProject
ON tblDepartment.depNum = tblProject.depNum
WHERE tblDepartment.depNum = 5

--Câu 3: Cho biết dự án có tên ProjectB hiện đang được quản lý bởi phòng ban nào. Thông tin yêu cầu: mã số dụ án, tên dự án, tên phòng ban quản lý
SELECT tblProject.proNum, tblProject.proName, tblDepartment.depName
FROM tblProject
INNER JOIN tblDepartment
ON tblProject.depNum = tblDepartment.depNum
WHERE tblProject.proName = 'ProjectB'

--Câu 4: Cho biết những nhân viên nào đang bị giám sát bởi nhân viên có tên Mai Duy An. Thông tin yêu cầu: mã số nhân viên, họ tên nhân viên
SELECT tblEmployee.empSSN, tblEmployee.empName
FROM tblEmployee
WHERE supervisorSSN = 30121050004

--Câu 5: Cho biết ai hiện đang giám sát những nhân viên có tên Mai Duy An. Thông tin yêu cầu: mã số nhân viên, họ tên nhân viên giám sát.
SELECT b.empSSN, b.empName
FROM tblEmployee AS a
join tblEmployee AS b ON a.supervisorSSN=b.empSSN and (a.empSSN = 30121050004)

--Câu 6: Cho biết dự án có tên ProjectA hiện đang làm việc ở đâu. Thông tin yêu cầu: mã số, tên vị trí làm việc
select tblLocation.locNum, tblLocation.locName
from tblProject
inner join tblLocation
on tblLocation.locNum = tblProject.locNum
where proName = 'ProjectA'


--Câu 7: Cho biết vị trí làm việc có tên Tp. HCM hiện đang là chỗ làm việc của những dự án nào. Thông tin yêu cầu: mã số, tên dự án
SELECT tblProject.proNum, tblProject.proName
FROM tblProject
INNER JOIN tblLocation
ON tblLocation.locNum = tblProject.locNum
WHERE tblLocation.locName LIKE N'Hồ%'

--Câu 8: Cho biết những người phụ thuộc trên 18 tuổi .Thông tin yêu cầu: tên, ngày tháng năm sinh của người phụ thuộc, tên nhân viên phụ thuộc vào
SELECT tblDependent.depName,CAST(tblDependent.depBirthdate AS date) As Birthday, YEAR(GETDATE()) - YEAR(tblDependent.depBirthdate) AS Age, tblEmployee.empName
FROM tblDependent
INNER JOIN tblEmployee
ON tblDependent.empSSN = tblEmployee.empSSN
WHERE YEAR(getdate())-YEAR(depBirthdate)> 18


--Câu 9: Cho biết những người phụ thuộc  là nam giới. Thông tin yêu cầu: tên, ngày tháng năm sinh của người phụ thuộc, tên nhân viên phụ thuộc vào 
SELECT tblDependent.depName, tblDependent.depBirthdate, tblEmployee.empName
FROM tblDependent
INNER JOIN tblEmployee
ON tblDependent.empSSN = tblEmployee.empSSN
WHERE tblDependent.depSex LIKE 'M'

--Câu 10: Cho biết những nơi làm việc của phòng ban có tên : Phòng Nghiên cứu và phát triển. Thông tin yêu cầu: mã phòng ban, tên phòng ban, tên nơi làm việc.
SELECT tblDepartment.depNum, tblDepartment.depName, tblLocation.locName
FROM tblDepLocation
INNER JOIN tblDepartment
ON tblDepartment.depNum = tblDepartment.depNum
INNER JOIN tblLocation
ON tblLocation.locNum = tblDepLocation.locNum
WHERE tblDepartment.depNum = 5

--Câu 11: Cho biết các dự án làm việc tại Tp. HCM. Thông tin yêu cầu: mã dự án, tên dự án, tên phòng ban chịu trách nhiệm dự án.
SELECT tblProject.proNum, tblProject.proName, tblDepartment.depName
FROM tblProject
INNER JOIN tblLocation
ON tblProject.locNum = tblLocation.locNum
INNER JOIN tblDepartment
ON tblProject.depNum = tblDepartment.depNum
WHERE tblLocation.locName LIKE N'%Minh'

--Câu 12: Cho biết những người phụ thuộc là nữ giới, của nhân viên thuộc phòng ban có tên: Phòng Nghiên cứu và phát triển . Thông tin yêu cầu: tên nhân viên, tên người phụ thuộc, mối liên hệ giữa người phụ thuộc với nhân viên
SELECT tblEmployee.empName, tblDependent.depName, tblDependent.depRelationship AS Relationship
FROM tblDependent
INNER JOIN tblEmployee
ON tblDependent.empSSN = tblEmployee.empSSN
WHERE tblEmployee.depNum = 5 AND tblDependent.depSex LIKE N'%F'

--Câu 13: Cho biết những người phụ thuộc trên 18 tuổi, của nhân viên thuộc phòng ban có tên: Phòng Nghiên cứu và phát triển. Thông tin yêu cầu: tên nhân viên, tên người phụ thuộc, mối liên hệ giữa người phụ thuộc với nhân viên
SELECT tblEmployee.empName, tblDependent.depName, tblDependent.depRelationship AS Relationship
FROM tblDependent
INNER JOIN tblEmployee
ON tblDependent.empSSN = tblEmployee.empSSN
WHERE tblEmployee.depNum = 5 AND YEAR(getdate())-YEAR(depBirthdate)> 18

--Câu 14: Cho biết số lượng người phụ thuộc theo giới tính. Thông tin yêu cầu: giới tính, số lượng người phụ thuộc
SELECT depSex, COUNT(depSex) as 'Count'
FROM tblDependent
GROUP BY depSex

--Câu 15: Cho biết số lượng người phụ thuộc theo mối liên hệ với nhân viên. Thông tin yêu cầu: mối liên hệ, số lượng người phụ thuộc
SELECT depRelationship, COUNT(depRelationship)
FROM tblDependent
GROUP BY depRelationship

--Câu 16: Cho biết số lượng người phụ thuộc theo mỗi phòng ban. Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng người phụ thuộc
SELECT tblDepartment.depNum, tblDepartment.depName, COUNT(tblDependent.depName) AS 'Số người phụ thuộc'
FROM tblEmployee
INNER JOIN tblDependent
ON tblEmployee.empSSN = tblDependent.empSSN
INNER JOIN tblDepartment
ON tblDepartment.depNum = tblEmployee.depNum
GROUP BY tblDepartment.depNum, tblDepartment.depName

--Câu 17: Cho biết phòng ban nào có số lượng người phụ thuộc là ít nhất. Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng người phụ thuộc
SELECT tblDepartment.depNum, tblDepartment.depName, COUNT(tblDependent.depName) as 'Số người phụ thuộc ít nhất'
FROM tblEmployee
inner join tblDepartment
on tblDepartment.depNum = tblEmployee.depNum
inner join tblDependent
on tblDependent.empSSN = tblEmployee.empSSN
Group by tblDepartment.depNum, tblDepartment.depName
having tblDepartment.depName in (SELECT top 1 tblDepartment.depName
                            FROM tblEmployee, tblDependent, tblDepartment
							WHERE tblDepartment.depNum = tblEmployee.depNum and tblDependent.empSSN = tblEmployee.empSSN
							GROUP BY tblDepartment.depName
							ORDER BY COUNT(tblDependent.depName) ASC)

--Câu 18: Cho biết phòng ban nào có số lượng người phụ thuộc là nhiều nhất. Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng người phụ thuộc
SELECT tblDepartment.depNum, tblDepartment.depName, COUNT(tblDependent.depName) as 'Số người phụ thuộc nhiều nhất'
FROM tblEmployee
inner join tblDepartment
on tblDepartment.depNum = tblEmployee.depNum
inner join tblDependent
on tblDependent.empSSN = tblEmployee.empSSN
Group by tblDepartment.depNum, tblDepartment.depName
having tblDepartment.depName in (SELECT top 2 tblDepartment.depName
                            FROM tblEmployee, tblDependent, tblDepartment
							WHERE tblDepartment.depNum = tblEmployee.depNum and tblDependent.empSSN = tblEmployee.empSSN
							GROUP BY tblDepartment.depName
							ORDER BY COUNT(tblDependent.depName) DESC)

--Câu 19: Cho biết tổng số giờ tham gia dự án của mỗi nhân viên. Thông tin yêu cầu: mã nhân viên, tên nhân viên, tên phòng ban của nhân viên
SELECT tblEmployee.empSSN, tblEmployee.empName, tblDepartment.depName, SUM(tblWorksOn.workHours) AS 'Tổng số giờ của nhân viên'
FROM tblEmployee
INNER JOIN tblDepartment
ON tblDepartment.depNum = tblEmployee.depNum
INNER JOIN tblWorksOn
ON tblWorksOn.empSSN = tblEmployee.empSSN
GROUP BY tblEmployee.empSSN, tblEmployee.empName, tblDepartment.depName

--Câu 20: Cho biết tổng số giờ làm dự án của mỗi phòng ban. Thông tin yêu cầu: mã phòng ban,  tên phòng ban, tổng số giờ
SELECT tblDepartment.depNum, tblDepartment.depName, SUM(tblWorksOn.workHours) AS 'Tổng số giờ'
FROM tblEmployee
INNER JOIN tblDepartment
ON tblEmployee.depNum = tblDepartment.depNum
INNER JOIN tblWorksOn
ON tblEmployee.empSSN = tblWorksOn.empSSN
GROUP BY tblDepartment.depNum, tblDepartment.depName
--Câu 21: Cho biết nhân viên nào có số giờ tham gia dự án là ít nhất. Thông tin yêu cầu: mã nhân viên, tên nhân viên, tổng số giờ tham gia dự án

--Câu 22: Cho biết nhân viên nào có số giờ tham gia dự án là nhiều nhất. Thông tin yêu cầu: mã nhân viên, tên nhân viên, tổng số giờ tham gia dự án
SELECT tblEmployee.empSSN,tblEmployee.empName, SUM(workHours) as 'TotalHour'
FROM tblEmployee
inner join tblWorksOn
on tblEmployee.empSSN = tblWorksOn.empSSN
Group by tblEmployee.empSSN,tblEmployee.empName
Having tblEmployee.empSSN = (SELECT TOP 1 tblEmployee.empSSN
                            FROM tblWorksOn, tblEmployee
							WHERE tblEmployee.empSSN = tblWorksOn.empSSN
							GROUP BY tblEmployee.empSSN
							ORDER BY SUM(workHours) DESC)

SELECT TOP 1 tblEmployee.empSSN, tblEmployee.empName
FROM tblWorksOn, tblEmployee
WHERE tblEmployee.empSSN = tblWorksOn.empSSN
GROUP BY tblEmployee.empSSN, tblEmployee.empName
ORDER BY SUM(workHours) DESC

--Câu 23: Cho biết những nhân viên nào lần đầu tiên tham gia dụ án. Thông tin yêu cầu: mã nhân viên, tên nhân viên, tên phòng ban của nhân viên
SELECT tblEmployee.empSSN, tblEmployee.empName, tblDepartment.depName
FROM tblEmployee
INNER JOIN tblDepartment
ON tblDepartment.depNum = tblEmployee.depNum
INNER JOIN tblWorksOn
ON tblEmployee.empSSN = tblWorksOn.empSSN
GROUP BY tblEmployee.empName, tblEmployee.empSSN, tblDepartment.depName
HAVING COUNT(tblEmployee.empSSN) = 1

--Câu 24: Cho biết những nhân viên nào lần thứ hai tham gia dụ án. Thông tin yêu cầu: mã nhân viên, tên nhân viên, tên phòng ban của nhân viên
SELECT tblEmployee.empSSN, tblEmployee.empName, tblDepartment.depName
FROM tblEmployee
INNER JOIN tblDepartment
ON tblDepartment.depNum = tblEmployee.depNum
INNER JOIN tblWorksOn
ON tblEmployee.empSSN = tblWorksOn.empSSN
GROUP BY tblEmployee.empName, tblEmployee.empSSN, tblDepartment.depName
HAVING COUNT(tblEmployee.empSSN) = 2

--Câu 25: Cho biết những nhân viên nào tham gia tối thiểu hai dụ án. Thông tin yêu cầu: mã nhân viên, tên nhân viên, tên phòng ban của nhân viên
SELECT tblEmployee.empSSN, tblEmployee.empName, tblDepartment.depName
FROM tblEmployee
INNER JOIN tblDepartment
ON tblDepartment.depNum = tblEmployee.depNum
INNER JOIN tblWorksOn
ON tblWorksOn.empSSN = tblEmployee.empSSN
GROUP BY tblDepartment.depName, tblEmployee.empSSN, tblEmployee.empName
HAVING COUNT(tblWorksOn.proNum) > 2

--Câu 26: Cho biết số lượng thành viên của mỗi dự án. Thông tin yêu cầu: mã dự án, tên dự án, số lượng thành viên
SELECT tblProject.proNum, tblProject.proName, COUNT(tblEmployee.empSSN) AS 'TotalEmployee'
FROM tblEmployee
INNER JOIN tblProject
ON tblProject.depNum = tblEmployee.depNum
GROUP BY tblProject.proNum, tblProject.proName

--Câu 27:Cho biết tổng số giờ làm của mỗi dự án. Thông tin yêu cầu: mã dự án, tên dự án, tổng số giờ làm
SELECT tblProject.proNum, tblProject.proName, COUNT(tblWorksOn.workHours) AS 'TotalHours'
FROM tblEmployee
INNER JOIN tblWorksOn
ON tblWorksOn.empSSN = tblEmployee.empSSN
INNER JOIN tblProject
ON tblProject.depNum = tblEmployee.depNum
GROUP BY tblProject.proNum, tblProject.proName

--Câu 28: Cho biết dự án nào có số lượng thành viên là ít nhất. Thông tin yêu cầu: mã dự án, tên dự án, số lượng thành viên

--Câu 29: Cho biết dự án nào có số lượng thành viên là nhiều nhất. Thông tin yêu cầu: mã dự án, tên dự án, số lượng thành viên

--Câu 30: Cho biết dự án nào có tổng số giờ làm là ít nhất. Thông tin yêu cầu: mã dự án, tên dự án, tổng số giờ làm

--Câu 31: Cho biết dự án nào có tổng số giờ làm là nhiều nhất. Thông tin yêu cầu: mã dự án, tên dự án, tổng số giờ làm

--Câu 32: Cho biết số lượng phòng ban làm việc theo mỗi nơi làm việc. Thông tin yêu cầu: tên nơi làm việc, số lượng phòng ban
SELECT tblLocation.locName, COUNT(tblDepartment.depName) AS ' TotalDepartment'
FROM tblDepLocation
INNER JOIN tblDepartment
ON tblDepLocation.depNum= tblDepartment.depNum
INNER JOIN tblLocation
ON tblDepLocation.locNum = tblLocation.locNum
GROUP BY tblLocation.locName

--Câu 33: Cho biết số lượng chỗ làm việc theo mỗi phòng ban. Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng chỗ làm việc
SELECT tblDepartment.depNum, tblDepartment.depName, COUNT(tblLocation.locNum) AS ' TotalLocation'
FROM tblDepLocation
INNER JOIN tblDepartment
ON tblDepLocation.depNum = tblDepartment.depNum
INNER JOIN tblLocation
ON tblDepLocation.locNum = tblLocation.locNum
GROUP BY tblDepartment.depNum, tblDepartment.depName

--Câu 34: Cho biết phòng ban nào có nhiều chỗ làm việc nhất. Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng chỗ làm việc


--Câu 35: Cho biết phòng ban nào có it chỗ làm việc nhất. Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng chỗ làm việc

--Câu 36: Cho biết địa điểm nào có nhiều phòng ban làm việc nhất. Thông tin yêu cầu: tên nơi làm việc, số lượng phòng ban

--Câu 37: Cho biết địa điểm nào có ít phòng ban làm việc nhất. Thông tin yêu cầu: tên nơi làm việc, số lượng phòng ban

--Câu 38: Cho biết nhân viên nào có nhiều người phụ thuộc nhất. Thông tin yêu cầu: mã số, họ tên nhân viên, số lượng người phụ thuộc

--Câu 39: Cho biết nhân viên nào có ít người phụ thuộc nhất. Thông tin yêu cầu: mã số, họ tên nhân viên, số lượng người phụ thuộc

--Câu 40: Cho biết nhân viên nào không có người phụ thuộc. Thông tin yêu cầu: mã số nhân viên, họ tên nhân viên, tên phòng ban của nhân viên
SELECT tblEmployee.empSSN, tblEmployee.empName, tblDepartment.depName
FROM tblEmployee
INNER JOIN tblDepartment
ON tblDepartment.depNum = tblEmployee.depNum
WHERE tblEmployee.supervisorSSN IS NULL
--Câu 41: Cho biết phòng ban nào không có người phụ thuộc. Thông tin yêu cầu: mã số phòng ban, tên phòng ban
SELECT tblDepartment.depNum, tblDepartment.depName
FROM tblEmployee
INNER JOIN tblDependent
ON tblEmployee.empSSN = tblDependent.empSSN
INNER JOIN tblDepartment
ON tblDepartment.depNum = tblEmployee.depNum
WHERE tblEmployee.supervisorSSN IS NULL
--Câu 42: Cho biết những nhân viên nào chưa hề tham gia vào bất kỳ dự án nào. Thông tin yêu cầu: mã số, tên nhân viên, tên phòng ban của nhân viên
SELECT tblEmployee.empSSN, tblEmployee.empName, tblDepartment.depName
FROM tblEmployee
INNER JOIN tblDepartment
ON tblDepartment.depNum = tblEmployee.depNum
INNER JOIN tblProject
ON  tblProject.depNum = tblDepartment.depNum
WHERE tblProject.proName IS NULL
====================================================================================
select tblEmployee.empSSN, tblEmployee.empName, tblDepartment.depName
from tblEmployee
full join tblProject
on tblProject.depNum = tblEmployee.depNum
full join tblDepartment
on tblDepartment.depNum = tblEmployee.depNum
group by tblEmployee.empSSN, tblEmployee.empName, tblDepartment.depName
having count(tblProject.proName) = 0
--Câu 43: Cho biết phòng ban không có nhân viên nào tham gia (bất kỳ) dự án. Thông tin yêu cầu: mã số phòng ban, tên phòng ban

--Câu 44: Cho biết phòng ban không có nhân viên nào tham gia vào dự án có tên là ProjectA. Thông tin yêu cầu: mã số phòng ban, tên phòng ban
SELECT distinct tblDepartment.depNum, tblDepartment.depName
from tblEmployee
inner join tblProject
on tblProject.depNum = tblEmployee.depNum
inner join tblDepartment
on tblDepartment.depNum = tblEmployee.depNum
where tblProject.proName not like 'ProjectA'

--Câu 45: Cho biết số lượng dự án được quản lý theo mỗi phòng ban. Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng dự án

--Câu 46: Cho biết phòng ban nào quản lý it dự án nhất. Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng dự án

--Câu 47: Cho biết phòng ban nào quản lý nhiều dự án nhất. Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng dự án

--Câu 48: Cho biết những phòng ban nào có nhiểu hơn 5 nhân viên đang quản lý dự án gì. Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng nhân viên của phòng ban, tên dự án quản lý

--Câu 49: Cho biết những nhân viên thuộc phòng có tên là Phòng nghiên cứu, và không có người phụ thuộc. Thông tin yêu cầu: mã nhân viên,họ tên nhân viên

--Câu 50: Cho biết tổng số giờ làm của các nhân viên, mà các nhân viên này không có người phụ thuộc. Thông tin yêu cầu: mã nhân viên,họ tên nhân viên, tổng số giờ làm
SELECT tblEmployee.empSSN, tblEmployee.empName, sum(tblWorksOn.workHours) as 'TotalHours'
FROM tblEmployee
LEFT join tblWorksOn
on tblEmployee.empSSN = tblWorksOn.empSSN
LEFT join tblDepartment
on tblDepartment.depNum = tblEmployee.depNum
LEFT join tblDependent
on tblDependent.empSSN = tblEmployee.empSSN
Group by tblEmployee.empSSN, tblEmployee.empName
having count(tblDependent.depName) = 0 

SELECT e.empSSN, sum(w.workHours) AS SumWorks
FROM tblEmployee e JOIN tblWorksOn w ON e.empSSN = w.empSSN
WHERE e.empSSN NOT IN (SELECT empSSN FROM tblDependent)
GROUP BY e.empSSN, e.empName
--Câu 51: Cho biết tổng số giờ làm của các nhân viên, mà các nhân viên này có nhiều hơn 3 người phụ thuộc. Thông tin yêu cầu: mã nhân viên,họ tên nhân viên, số lượng người phụ thuộc, tổng số giờ làm

--Câu 52: Cho biết tổng số giờ làm việc của các nhân viên hiện đang dưới quyền giám sát (bị quản lý bởi) của nhân viên Mai Duy An. Thông tin yêu cầu: mã nhân viên, họ tên nhân viên, tổng số giờ làm

DECLARE @empName NVARCHAR(20), @empSSN as Decimal,
	@empSalary Decimal=1000