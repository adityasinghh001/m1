using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;

namespace ConApp_XmlDemos
{
    class DOM_WritingXml_Demo
    {
        static void Main()
        {
            List<Student> studentList = new List<Student>(){
                new Student(){RollNo = 1, Name = "Kiran Jadhav", Marks1 = 52, Marks2 = 43, Marks3 = 55, Avg= 50},
                new Student(){RollNo = 2, Name = "Girish Lohar", Marks1 = 47, Marks2 = 48, Marks3 = 58, Avg= 51},
                new Student(){RollNo = 3, Name = "Seeta Lohia", Marks1 = 80, Marks2 = 62, Marks3 = 59, Avg= 67},
            };

            XmlDocument doc = new XmlDocument();
            XmlElement e_Students = doc.CreateElement("Students"); //Creating root element 'Students'
            foreach (Student student in studentList)
            {
                XmlElement e_Student = doc.CreateElement("Student");

                XmlAttribute a_RollNo = doc.CreateAttribute("RollNo");
                a_RollNo.Value = student.RollNo.ToString();
                e_Student.Attributes.Append(a_RollNo);

                XmlElement e_Name = doc.CreateElement("Name");
                e_Name.InnerXml = student.Name.ToString();
                e_Student.AppendChild(e_Name);

                XmlElement e_Marks = doc.CreateElement("Marks");

                XmlElement e_S1 = doc.CreateElement("Subject1");
                e_S1.InnerXml = student.Marks1.ToString();
                e_Marks.AppendChild(e_S1);

                XmlElement e_S2 = doc.CreateElement("Subject2");
                e_S2.InnerXml = student.Marks2.ToString();
                e_Marks.AppendChild(e_S2);

                XmlElement e_S3 = doc.CreateElement("Subject3");
                e_S3.InnerXml = student.Marks3.ToString();
                e_Marks.AppendChild(e_S3);

                e_Student.AppendChild(e_Marks);
               
                XmlElement e_AvgMarks = doc.CreateElement("AvgMarks");
                e_AvgMarks.InnerXml = student.Avg.ToString();
                e_Student.AppendChild(e_AvgMarks);

                e_Students.AppendChild(e_Student);
            }
            doc.AppendChild(e_Students);  //Appending the root element 'Students' to doc
            doc.Save("Students.xml");

        }
    }
}
