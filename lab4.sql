
use FUH_COMPANY
/*Q1:Cho biết Mã số, học tên nhân viên, tên phòng ban 
của nhân viên quản lí Phòng Nghiên cứu và phát triển*/
select tblEmployee.empSSN, tblEmployee.empName, tblDepartment.depName
from tblDepartment
inner join  tblEmployee
on tblDepartment.depNum = tblEmployee.depNum
where tblDepartment.depNum = 5


/*Q2:Phong nghien cuu va phat trien dang quan ly du an nao.
Thong tin yeu cau: ma du an, ten du an, ten phong ban quan ly*/
select tblProject.proNum, tblProject.proName, tblDepartment.depName
from tblDepartment 
full join tblProject
on tblDepartment.depNum = tblProject.depNum
where tblDepartment.depNum = 5


/*Q3: Mã số dự án, tên dự án, tên phòng ban của projectB*/
select tblProject.proNum, tblProject.proName, tblDepartment.depName
from tblProject
inner join tblDepartment 
on tblDepartment.depNum = tblProject.depNum
where proName = 'ProjectB'


/*Q4: Cho biết mã số nhân viên, họ tên nhân viên của người đang BỊ giám sát BỞI Mai Duy An*/
select empSSN, empName
from tblEmployee
where supervisorSSN = 30121050004

/*Q5: Cho biết mã số NV, họ tên NV giám sát của những người đang giám sát Mai Duy An*/
select supervisorSSN, empName
from tblEmployee
where empName = 'Mai Duy An' 


/*Q6: Cho biết dự án có tên projectA hiện đnag làm việc ở đâu.
Thông tin yêu câu: mã số, tên vị trí làm việc*/
select tblLocation.locNum, tblLocation.locName
from tblProject
inner join tblLocation
on tblLocation.locNum = tblProject.locNum
where proName = 'ProjectA'


/*Q7: Cho biết mã số dự án, tên dự án có vị trí làm việc ở TPHCM*/
select tblProject.proNum, tblProject.proName
from tblLocation 
inner join tblProject
on tblLocation.locNum = tblProject.locNum
where locName LIKE '%Minh'


/*Q8: Cho biết những người phụ thuộc trên 18 tuổi. Thông tin yêu cầu tên, 
ngày tháng năm sinh của người phụ thuộc, tên nhân viên phụ thuộc vào*/
select tblDependent.depName,CAST(tblDependent.depBirthdate as date), 
YEAR(getdate())-YEAR(depBirthdate) as Age, tblEmployee.empName
from tblDependent
inner join  tblEmployee
on tblDependent.empSSN = tblEmployee.empSSN
where  YEAR(getdate())-YEAR(depBirthdate)> 18


/*Q9: Cho biết những người phụ thuộc là Nam giới ('M'). Thông tin yêu cầu:
tên, birthdate của người phụ thuộc, tên nhân viên phụ thuộc vào*/
select tblDependent.depName,tblDependent.depBirthdate, tblEmployee.empName
from tblDependent
inner join  tblEmployee
on tblDependent.empSSN = tblEmployee.empSSN
where depSex = 'M'


/*Q10: Cho biết những nơi làm việc của phòng ban có tên : Phòng Nghiên cứu và phát triển. Thông tin 
yêu cầu: mã phòng ban, tên phòng ban, tên nơi làm việc*/
select tblDepartment.depNum, tblDepartment.depName, tblLocation.locName
from tblDepLocation
inner join tblDepartment
on tblDepLocation.depNum = tblDepartment.depNum
inner join tblLocation
on tblDepLocation.locNum = tblLocation.locNum
where tblDepartment.depNum = 5


/*Q11: Cho biết các dự án làm việc tại Tp. HCM. Thông tin yêu cầu: mã dự án, tên dự án, tên phòng ban 
chịu trách nhiệm dự án */
select  tblLocation.locName as WorkPlace, tblDepartment.depNum, tblDepartment.depName
from tblDepLocation
inner join tblDepartment
on tblDepLocation.depNum = tblDepartment.depNum
inner join tblLocation
on tblDepLocation.locNum = tblLocation.locNum
where tblLocation.locName like '%Minh'


/*Q12: Cho biết những người phụ thuộc là nữ giới, của nhân viên thuộc phòng ban có tên: Phòng Nghiên 
cứu và phát triển . Thông tin yêu cầu: tên nhân viên, tên người phụ thuộc, mối liên hệ giữa người 
phụ thuộc với nhân viên*/
select tblEmployee.empName, tblDependent.depName, tblDependent.depRelationship
from tblDependent
inner join  tblEmployee
on tblDependent.empSSN = tblEmployee.empSSN
where depSex = 'F' and tblEmployee.depNum = 5


/*Q13: Cho biết những người phụ thuộc trên 18 tuổi, của nhân viên thuộc phòng ban có tên: Phòng 
Nghiên cứu và phát triển. Thông tin yêu cầu: tên nhân viên, tên người phụ thuộc, mối liên hệ 
giữa người phụ thuộc với nhân viên*/
select tblEmployee.empName, tblDependent.depName, tblDependent.depRelationship
from tblDependent
inner join  tblEmployee
on tblDependent.empSSN = tblEmployee.empSSN
where  YEAR(getdate())-YEAR(depBirthdate)>18 and tblEmployee.depNum = 5


/*Q14: Cho biết số lượng người phụ thuộc theo giới tính. Thông tin yêu cầu: giới tính, số lượng người 
phụ thuộc*/
SELECT depSex, COUNT(depSex) as 'Count'
FROM tblDependent
Group by depSex


/*Q15: Cho biết số lượng người phụ thuộc theo mối liên hệ với nhân viên. Thông tin yêu cầu: mối liên hệ, 
số lượng người phụ thuộc*/
SELECT depRelationship, COUNT(depRelationship) as 'Count'
FROM tblDependent
Group by depRelationship


/*Q16: Cho biết số lượng người phụ thuộc theo mỗi phòng ban. Thông tin yêu cầu: mã phòng ban, tên 
phòng ban, số lượng người phụ thuộc*/
SELECT tblDepartment.depNum,tblDepartment.depName, COUNT(tblDependent.depName) as 'Số người phụ thuộc'
FROM tblEmployee
inner join tblDepartment
on tblDepartment.depNum = tblEmployee.depNum
inner join tblDependent
on tblDependent.empSSN = tblEmployee.empSSN
Group by tblDepartment.depNum,tblDepartment.depName


/*Q17: Cho biết phòng ban nào có số lượng người phụ thuộc là ít nhất. Thông tin yêu cầu: mã phòng 
ban, tên phòng ban, số lượng người phụ thuộc*/
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


/*Q18: Cho biết phòng ban nào có số lượng người phụ thuộc là nhiều nhất. Thông tin yêu cầu: mã 
phòng ban, tên phòng ban, số lượng người phụ thuộc*/
SELECT tblDepartment.depNum, tblDepartment.depName, COUNT(tblDependent.depName) as 'Số người phụ thuộc ít nhất'
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
			
			
/*Q19: Cho biết tổng số giờ tham gia dự án của mỗi nhân viên. Thông tin yêu cầu: mã nhân viên, tên 
nhân viên, tên phòng ban của nhân viên*/
SELECT tblEmployee.empSSN, tblEmployee.empName,tblDepartment.depName, sum(workHours) as 'TotalHours'
FROM tblEmployee
inner join tblWorksOn
on tblEmployee.empSSN = tblWorksOn.empSSN
inner join tblDepartment
on tblDepartment.depNum = tblEmployee.depNum
Group by tblEmployee.empSSN, tblEmployee.empName,tblDepartment.depName


/*Q20: Cho biết tổng số giờ làm dự án của mỗi phòng ban. Thông tin yêu cầu: mã phòng ban, tên phòng 
ban, tổng số giờ*/
SELECT tblDepartment.depNum,tblDepartment.depName, sum(workHours) as 'TotalHours'
FROM tblEmployee
inner join tblWorksOn
on tblEmployee.empSSN = tblWorksOn.empSSN
inner join tblDepartment
on tblDepartment.depNum = tblEmployee.depNum
Group by tblDepartment.depNum,tblDepartment.depName


/*Q21: Cho biết nhân viên nào có số giờ tham gia dự án là ít nhất. Thông tin yêu cầu: mã nhân viên, tên 
nhân viên, tổng số giờ tham gia dự án*/
SELECT tblEmployee.empSSN,tblEmployee.empName, SUM(workHours) as 'TotalHour'
FROM tblEmployee
inner join tblWorksOn
on tblEmployee.empSSN = tblWorksOn.empSSN
Group by tblEmployee.empSSN,tblEmployee.empName
Having tblEmployee.empSSN = (SELECT TOP 1 tblEmployee.empSSN
                            FROM tblWorksOn, tblEmployee
							WHERE tblEmployee.empSSN = tblWorksOn.empSSN
							GROUP BY tblEmployee.empSSN
							ORDER BY SUM(workHours) ASC)


/*Q22:  Cho biết nhân viên nào có số giờ tham gia dự án là nhiều nhất. Thông tin yêu cầu: mã nhân viên, 
tên nhân viên, tổng số giờ tham gia dự án*/
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


/*Q23: Cho biết những nhân viên nào lần đầu tiên tham gia dụ án. Thông tin yêu cầu: mã nhân viên, tên 
nhân viên, tên phòng ban của nhân viên*/
SELECT tblEmployee.empSSN, tblEmployee.empName,tblDepartment.depName
FROM tblEmployee
inner join tblWorksOn
on tblEmployee.empSSN = tblWorksOn.empSSN
inner join tblDepartment
on tblDepartment.depNum = tblEmployee.depNum
Group by tblEmployee.empSSN, tblEmployee.empName,tblDepartment.depName
having count(tblEmployee.empSSN) = 1


/*Q24: Cho biết những nhân viên nào lần thứ hai tham gia dụ án. Thông tin yêu cầu: mã nhân viên, tên 
nhân viên, tên phòng ban của nhân viên*/
SELECT tblEmployee.empSSN, tblEmployee.empName,tblDepartment.depName
FROM tblEmployee
inner join tblWorksOn
on tblEmployee.empSSN = tblWorksOn.empSSN
inner join tblDepartment
on tblDepartment.depNum = tblEmployee.depNum
Group by tblEmployee.empSSN, tblEmployee.empName,tblDepartment.depName
having count(tblEmployee.empSSN) = 2


/*Q25: Cho biết những nhân viên nào tham gia tối thiểu hai dụ án. Thông tin yêu cầu: mã nhân viên, tên 
nhân viên, tên phòng ban của nhân viên*/
SELECT tblEmployee.empSSN, tblEmployee.empName,tblDepartment.depName
FROM tblEmployee
inner join tblWorksOn
on tblEmployee.empSSN = tblWorksOn.empSSN
inner join tblDepartment
on tblDepartment.depNum = tblEmployee.depNum
Group by tblEmployee.empSSN, tblEmployee.empName,tblDepartment.depName
having count(tblEmployee.empSSN) >=2


/*Q26: Cho biết số lượng thành viên của mỗi dự án. Thông tin yêu cầu: mã dự án, tên dự án, số lượng 
thành viên*/
SELECT tblProject.proNum,tblProject.proName, COUNT(empSSN) as 'Số lượng thành viên'
FROM tblProject
inner join tblEmployee
on tblProject.depNum = tblEmployee.depNum
Group by tblProject.proNum,tblProject.proName


/*Q27: Cho biết tổng số giờ làm của mỗi dự án. Thông tin yêu cầu: mã dự án, tên dự án, tổng số giờ làm*/
SELECT tblProject.proNum,tblProject.proName, sum(workHours) as 'TotalHours'
FROM tblProject
inner join tblDepartment
on tblProject.depNum = tblDepartment.depNum
inner join tblWorksOn
on tblProject.proNum = tblWorksOn.proNum
Group by tblProject.proNum,tblProject.proName


/*Q28: Cho biết dự án nào có số lượng thành viên là ít nhất. Thông tin yêu cầu: mã dự án, tên dự án, số 
lượng thành viên*/
SELECT tblProject.proNum,tblProject.proName, count(empSSN) as 'Số lượng thành viên'
FROM tblEmployee
inner join tblProject
on tblProject.depNum = tblEmployee.depNum  
Group by tblProject.proNum,tblProject.proName
Having tblProject.proName in (SELECT top 2 tblProject.proName
                            FROM tblProject, tblEmployee
							WHERE tblEmployee.depNum = tblProject.depNum
							GROUP BY tblProject.proName
							ORDER BY count(empSSN) ASC)


/*Q29: Cho biết dự án nào có số lượng thành viên là nhiều nhất. Thông tin yêu cầu: mã dự án, tên dự 
án, số lượng thành viên*/
SELECT tblProject.proNum,tblProject.proName, count(empSSN) as 'Số lượng thành viên'
FROM tblEmployee
inner join tblProject
on tblProject.depNum = tblEmployee.depNum  
Group by tblProject.proNum,tblProject.proName
Having tblProject.proName in  (SELECT top 3 tblProject.proName
                            FROM tblProject, tblEmployee
							WHERE tblEmployee.depNum = tblProject.depNum
							GROUP BY tblProject.proName
							ORDER BY count(empSSN) DESC)


/*Q30: Cho biết dự án nào có tổng số giờ làm là ít nhất. Thông tin yêu cầu: mã dự án, tên dự án, tổng số 
giờ làm*/
SELECT tblProject.proNum,tblProject.proName, sum(workHours) as 'LeastHours'
FROM tblProject
inner join tblDepartment
on tblProject.depNum = tblDepartment.depNum
inner join tblWorksOn
on tblProject.proNum = tblWorksOn.proNum
Group by tblProject.proNum,tblProject.proName
Having tblProject.proName in (SELECT top 1 tblProject.proName
                            FROM tblProject, tblWorksOn
							WHERE tblProject.proNum = tblWorksOn.proNum
							GROUP BY tblProject.proName
							ORDER BY sum(workHours) ASC)


/*Q31: Cho biết dự án nào có tổng số giờ làm là nhiều nhất. Thông tin yêu cầu: mã dự án, tên dự án, 
tổng số giờ làm*/
SELECT tblProject.proNum,tblProject.proName, sum(workHours) as 'MostHours'
FROM tblProject
inner join tblDepartment
on tblProject.depNum = tblDepartment.depNum
inner join tblWorksOn
on tblProject.proNum = tblWorksOn.proNum
Group by tblProject.proNum,tblProject.proName
Having tblProject.proName in (SELECT top 1 tblProject.proName
                            FROM tblProject, tblWorksOn
							WHERE tblProject.proNum = tblWorksOn.proNum
							GROUP BY tblProject.proName
							ORDER BY sum(workHours) DESC)


/*Q32: Cho biết số lượng phòng ban làm việc theo mỗi nơi làm việc. Thông tin yêu cầu: tên nơi làm việc, 
số lượng phòng ban*/
SELECT locName, COUNT(depNum) as 'CountDepartment'
FROM tblDepLocation
inner join tblLocation
on tblDepLocation.locNum = tblLocation.locNum
group by locName


/*Q33: Cho biết số lượng chỗ làm việc theo mỗi phòng ban. Thông tin yêu cầu: mã phòng ban, tên 
phòng ban, số lượng chỗ làm việc*/
SELECT tblDepartment.depNum, tblDepartment.depName, COUNT(locName) as 'CountPlace'
FROM tblDepLocation
inner join tblLocation
on tblDepLocation.locNum = tblLocation.locNum
inner join tblDepartment
on tblDepartment.depNum = tblDepLocation.depNum
group by tblDepartment.depNum, tblDepartment.depName


/*Q34: Cho biết phòng ban nào có nhiều chỗ làm việc nhất. Thông tin yêu cầu: mã phòng ban, tên phòng 
ban, số lượng chỗ làm việc*/
SELECT tblDepartment.depNum, tblDepartment.depName, COUNT(locName) as 'MostPlace'
FROM tblDepLocation
inner join tblLocation
on tblDepLocation.locNum = tblLocation.locNum
inner join tblDepartment
on tblDepartment.depNum = tblDepLocation.depNum
group by tblDepartment.depNum, tblDepartment.depName
having tblDepartment.depName in (SELECT top 1 tblDepartment.depName
                            FROM tblLocation, tblDepLocation, tblDepartment
							WHERE tblDepLocation.locNum = tblLocation.locNum and tblDepartment.depNum = tblDepLocation.depNum
							GROUP BY tblDepartment.depName
							ORDER BY COUNT(locName) DESC)


/*Q35: Cho biết phòng ban nào có it chỗ làm việc nhất. Thông tin yêu cầu: mã phòng ban, tên phòng 
ban, số lượng chỗ làm việc*/
SELECT tblDepartment.depNum, tblDepartment.depName, COUNT(locName) as 'LeastPlace'
FROM tblDepLocation
inner join tblLocation
on tblDepLocation.locNum = tblLocation.locNum
inner join tblDepartment
on tblDepartment.depNum = tblDepLocation.depNum
group by tblDepartment.depNum, tblDepartment.depName
having tblDepartment.depName in (SELECT top 1 tblDepartment.depName
                            FROM tblLocation, tblDepLocation, tblDepartment
							WHERE tblDepLocation.locNum = tblLocation.locNum and tblDepartment.depNum = tblDepLocation.depNum
							GROUP BY tblDepartment.depName
							ORDER BY COUNT(locName) ASC)


/*Q36: Cho biết địa điểm nào có nhiều phòng ban làm việc nhất. Thông tin yêu cầu: tên nơi làm việc, số 
lượng phòng ban*/
SELECT tblLocation.locName, COUNT(depNum) as 'MostDepartment'
FROM tblDepLocation
inner join tblLocation
on tblDepLocation.locNum = tblLocation.locNum
group by tblLocation.locName 
having  tblLocation.locName in (SELECT top 1 tblLocation.locName
                            FROM tblLocation, tblDepLocation
							WHERE tblDepLocation.locNum = tblLocation.locNum
							GROUP BY  tblLocation.locName
							ORDER BY COUNT(depNum) DESC)


/*Q37: Cho biết địa điểm nào có ít phòng ban làm việc nhất. Thông tin yêu cầu: tên nơi làm việc, số 
lượng phòng ban*/
SELECT tblLocation.locName, COUNT(depNum) as 'LeastDepartment'
FROM tblDepLocation
inner join tblLocation
on tblDepLocation.locNum = tblLocation.locNum
group by tblLocation.locName 
having  tblLocation.locName in (SELECT top 1 tblLocation.locName
                            FROM tblLocation, tblDepLocation
							WHERE tblDepLocation.locNum = tblLocation.locNum
							GROUP BY  tblLocation.locName
							ORDER BY COUNT(depNum) ASC)

							
/*Q38: Cho biết nhân viên nào có nhiều người phụ thuộc nhất. Thông tin yêu cầu: mã số, họ tên nhân 
viên, số lượng người phụ thuộc*/
SELECT tblEmployee.empSSN, tblEmployee.empName, COUNT(tblDependent.depName) as 'Số người phụ thuộc'
FROM tblEmployee
inner join tblDependent
on tblDependent.empSSN = tblEmployee.empSSN
Group by tblEmployee.empSSN, tblEmployee.empName
Having tblEmployee.empName in  (SELECT top 15 tblEmployee.empName
                            FROM tblDependent, tblEmployee
							WHERE tblDependent.empSSN = tblEmployee.empSSN
							GROUP BY tblEmployee.empName
							ORDER BY count(depName) DESC)


/*Q39: Cho biết nhân viên nào có ít người phụ thuộc nhất. Thông tin yêu cầu: mã số, họ tên nhân viên, 
số lượng người phụ thuộc*/
SELECT tblEmployee.empSSN, tblEmployee.empName, COUNT(tblDependent.depName) as 'Số người phụ thuộc'
FROM tblEmployee
inner join tblDependent
on tblDependent.empSSN = tblEmployee.empSSN
Group by tblEmployee.empSSN, tblEmployee.empName
Having tblEmployee.empName in  (SELECT top 15 tblEmployee.empName
                            FROM tblDependent, tblEmployee
							WHERE tblDependent.empSSN = tblEmployee.empSSN
							GROUP BY tblEmployee.empName
							ORDER BY count(depName) ASC)


/*Q40: Cho biết nhân viên nào không có người phụ thuộc. Thông tin yêu cầu: mã số nhân viên, họ tên 
nhân viên, tên phòng ban của nhân viên*/
SELECT tblEmployee.empSSN, tblEmployee.empName, tblDepartment.depName
from tblEmployee
inner join tblDepartment
on tblDepartment.depNum = tblEmployee.depNum
where tblEmployee.empSSN not in (select tblDependent.empSSN
                                 from tblEmployee, tblDependent
								 where tblEmployee.empSSN = tblDependent.empSSN)

/*Q40- Cách 2*/
SELECT tblEmployee.empSSN, tblEmployee.empName, tblDepartment.depName
FROM tblEmployee
full join tblDependent
on tblDependent.empSSN = tblEmployee.empSSN
full join tblDepartment
on tblEmployee.depNum = tblDepartment.depNum
Group by tblEmployee.empSSN, tblEmployee.empName, tblDepartment.depName
having COUNT(tblDependent.depName) = 0


/*Q41: Cho biết phòng ban nào không có người phụ thuộc. Thông tin yêu cầu: mã số phòng ban, tên 
phòng ban*/
SELECT tblDepartment.depNum, tblDepartment.depName
FROM tblEmployee
full join tblDependent
on tblDependent.empSSN = tblEmployee.empSSN
full join tblDepartment
on tblEmployee.depNum = tblDepartment.depNum
Group by tblDepartment.depNum, tblDepartment.depName
having COUNT(tblDependent.depName) = 0


/*Q42: Cho biết những nhân viên nào chưa hề tham gia vào bất kỳ dự án nào. Thông tin yêu cầu: mã số, 
tên nhân viên, tên phòng ban của nhân viên*/
select tblEmployee.empSSN, tblEmployee.empName, tblDepartment.depName
from tblEmployee
full join tblProject
on tblProject.depNum = tblEmployee.depNum
full join tblDepartment
on tblDepartment.depNum = tblEmployee.depNum
group by tblEmployee.empSSN, tblEmployee.empName, tblDepartment.depName
having count(tblProject.proName) = 0


/*Q43: Cho biết phòng ban không có nhân viên nào tham gia (bất kỳ) dự án. Thông tin yêu cầu: mã số 
phòng ban, tên phòng ban*/
SELECT tblDepartment.depNum, tblDepartment.depName
from tblEmployee
full join tblProject
on tblProject.depNum = tblEmployee.depNum
full join tblDepartment
on tblDepartment.depNum = tblEmployee.depNum
Group by tblDepartment.depNum, tblDepartment.depName
having count(tblProject.proName) = 0


/*Q44: Cho biết phòng ban không có nhân viên nào tham gia vào dự án có tên là ProjectA. Thông tin yêu 
cầu: mã số phòng ban, tên phòng ban*/
SELECT distinct tblDepartment.depNum, tblDepartment.depName
from tblEmployee
inner join tblProject
on tblProject.depNum = tblEmployee.depNum
inner join tblDepartment
on tblDepartment.depNum = tblEmployee.depNum
where tblProject.proName not like 'ProjectA'


/*Q45: Cho biết số lượng dự án được quản lý theo mỗi phòng ban. Thông tin yêu cầu: mã phòng ban, 
tên phòng ban, số lượng dự án*/
SELECT tblDepartment.depNum,tblDepartment.depName, count(proName) as 'Số lượng Dự án'
FROM tblDepartment
left join tblProject
on tblDepartment.depNum = tblProject.depNum
Group by tblDepartment.depNum,tblDepartment.depName


/*Q46: Cho biết phòng ban nào quản lý it dự án nhất. Thông tin yêu cầu: mã phòng ban, tên phòng ban, 
số lượng dự án*/
SELECT tblDepartment.depNum,tblDepartment.depName, count(tblProject.proName) as 'Số lượng Dự án'
FROM tblDepartment
inner join tblProject
on tblDepartment.depNum = tblProject.depNum
Group by tblDepartment.depNum,tblDepartment.depName
having tblDepartment.depName  in (SELECT top 1 tblDepartment.depName
                            FROM tblDepartment, tblProject
							WHERE tblDepartment.depNum = tblProject.depNum
							GROUP BY  tblDepartment.depName
							ORDER BY COUNT(tblProject.proName) ASC)


/*Q47: Cho biết phòng ban nào quản lý nhiều dự án nhất. Thông tin yêu cầu: mã phòng ban, tên phòng 
ban, số lượng dự án*/
SELECT tblDepartment.depNum,tblDepartment.depName, count(tblProject.proName) as 'Số lượng Dự án'
FROM tblDepartment
left join tblProject
on tblDepartment.depNum = tblProject.depNum
Group by tblDepartment.depNum,tblDepartment.depName
having tblDepartment.depName  in (SELECT top 1 tblDepartment.depName
                            FROM tblDepartment, tblProject
							WHERE tblDepartment.depNum = tblProject.depNum
							GROUP BY  tblDepartment.depName
							ORDER BY COUNT(tblProject.proName) DESC)


/*Q48: Cho biết những phòng ban nào có nhiểu hơn 5 nhân viên đang quản lý dự án gì. Thông tin yêu 
cầu: mã phòng ban, tên phòng ban, số lượng nhân viên của phòng ban, tên dự án quản lý*/
SELECT tblDepartment.depNum, tblDepartment.depName, COUNT(tblEmployee.empName) as 'Số lượng nhân viên', tblProject.proName  
FROM tblDepartment
inner join tblProject
on tblDepartment.depNum = tblProject.depNum
inner join tblEmployee
on tblDepartment.depNum = tblEmployee.depNum
GROUP BY tblDepartment.depNum, tblDepartment.depName, tblProject.proName  
HAVING COUNT(tblEmployee.empName) >= 5


/*Q49: Cho biết những nhân viên thuộc phòng có tên là Phòng nghiên cứu, và không có người phụ 
thuộc. Thông tin yêu cầu: mã nhân viên,họ tên nhân viên*/
select tblEmployee.empSSN, tblEmployee.empName
from tblEmployee
full join tblDepartment
on tblDepartment.depNum = tblEmployee.depNum
full join tblDependent
on tblDependent.empSSN = tblEmployee.empSSN
where tblDepartment.depNum = 5
group by tblEmployee.empSSN, tblEmployee.empName
having count(tblDependent.depName) = 0 


/*Q50:  Cho biết tổng số giờ làm của các nhân viên, mà các nhân viên này không có người phụ thuộc. 
Thông tin yêu cầu: mã nhân viên,họ tên nhân viên, tổng số giờ làm*/
SELECT tblEmployee.empSSN, tblEmployee.empName, sum(tblWorksOn.workHours) as 'TotalHours'
FROM tblEmployee
full join tblWorksOn
on tblEmployee.empSSN = tblWorksOn.empSSN
full join tblDepartment
on tblDepartment.depNum = tblEmployee.depNum
full join tblDependent
on tblDependent.empSSN = tblEmployee.empSSN
Group by tblEmployee.empSSN, tblEmployee.empName
having count(tblDependent.depName) = 0 

/*Q51: Cho biết tổng số giờ làm của các nhân viên, mà các nhân viên này có nhiều hơn 3 người phụ 
thuộc. Thông tin yêu cầu: mã nhân viên,họ tên nhân viên, số lượng người phụ thuộc, tổng số giờ 
làm*/
SELECT tblEmployee.empSSN, tblEmployee.empName, count(tblDependent.depName) as 'Số lượng người phụ thuộc', sum(tblWorksOn.workHours) as 'TotalHours'
FROM tblEmployee
full join tblWorksOn
on tblEmployee.empSSN = tblWorksOn.empSSN
full join tblDepartment
on tblDepartment.depNum = tblEmployee.depNum
full join tblDependent
on tblDependent.empSSN = tblEmployee.empSSN
Group by tblEmployee.empSSN, tblEmployee.empName
having count(tblDependent.depName) > 3

/*Q52: Cho biết tổng số giờ làm việc của các nhân viên hiện đang dưới quyền giám sát (bị quản lý bởi) 
của nhân viên Mai Duy An. Thông tin yêu cầu: mã nhân viên, họ tên nhân viên, tổng số giờ làm*/
SELECT tblEmployee.empSSN, tblEmployee.empName, sum(tblWorksOn.workHours) as 'TotalHours'
FROM tblEmployee
left join tblWorksOn
on tblEmployee.empSSN = tblWorksOn.empSSN
where supervisorSSN = 30121050004
Group by tblEmployee.empSSN, tblEmployee.empName