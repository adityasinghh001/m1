using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;

namespace ConApp_XmlDemos
{
    class SAX_SampleApp
    {
        static Student GetStudent()
        {
            Student s1 = new Student();
            Console.Write("Enter RollNo :");
            s1.RollNo = int.Parse(Console.ReadLine());
            Console.Write("Enter Name: ");
            s1.Name = Console.ReadLine();
            Console.Write("Enter Subject1 Marks: ");
            s1.Marks1 = float.Parse(Console.ReadLine());
            Console.Write("Enter Subject2 Marks: ");
            s1.Marks2 = float.Parse(Console.ReadLine());
            Console.Write("Enter Subject3 Marks: ");
            s1.Marks3 = float.Parse(Console.ReadLine());
            s1.Avg = (s1.Marks1 + s1.Marks2 + s1.Marks3) / 3;
            return s1;
        }

        static void StoreStudentsInXml(List<Student> studentList)
        {
            XmlTextWriter xmlWriter = new XmlTextWriter("Students.xml", Encoding.Unicode);
            xmlWriter.WriteStartElement("Students"); //creating root Students
            foreach (Student s in studentList)
            {
                xmlWriter.WriteStartElement("Student");  //creating element Student
                
                xmlWriter.WriteStartAttribute("RollNo");
                xmlWriter.WriteValue(s.RollNo);
                xmlWriter.WriteEndAttribute();

                xmlWriter.WriteStartElement("Name");
                xmlWriter.WriteString(s.Name);
                xmlWriter.WriteEndElement();                

                xmlWriter.WriteStartElement("Marks"); //creating element Marks
                xmlWriter.WriteStartElement("Subject1");
                xmlWriter.WriteString(s.Marks3.ToString());
                xmlWriter.WriteEndElement();
                xmlWriter.WriteStartElement("Subject2");
                xmlWriter.WriteString(s.Marks3.ToString());
                xmlWriter.WriteEndElement();
                xmlWriter.WriteStartElement("Subject3");
                xmlWriter.WriteString(s.Marks3.ToString());
                xmlWriter.WriteEndElement();
                xmlWriter.WriteEndElement();//closing element Marks

                xmlWriter.WriteStartElement("AvgMarks");
                xmlWriter.WriteString(s.Avg.ToString());
                xmlWriter.WriteEndElement();

                xmlWriter.WriteEndElement();  //closing element Student
            }
            xmlWriter.WriteEndElement(); // closing root Students

            xmlWriter.Close();
        }        

        static List<Student> RetriveStudentFromXml()
        {
            List<Student> studentList = new List<Student>();
            XmlTextReader xmlReader = new XmlTextReader("Students.xml");
            Student s1 = null;
            while (xmlReader.Read())
            {
                if (xmlReader.IsStartElement())
                {                    
                    switch (xmlReader.Name)
                    {

                        case "Student":
                            s1 = new Student();
                            s1.RollNo = int.Parse(xmlReader.GetAttribute(0)); break;
                        case "Name": s1.Name = xmlReader.ReadString(); break;
                        case "Subject1": s1.Marks1 = float.Parse(xmlReader.ReadString()); 
                            break;
                        case "Subject2": s1.Marks2 = float.Parse(xmlReader.ReadString()); 
                            break;
                        case "Subject3": s1.Marks3 = float.Parse(xmlReader.ReadString()); 
                            break;
                        case "AvgMarks":
                            s1.Avg = float.Parse(xmlReader.ReadString());
                            studentList.Add(s1);
                            s1 = null; break;
                    }
                }
            }
            xmlReader.Close();
            return studentList;
        }

        static void DisplayStudents(List<Student> studentList)
        {
            foreach (Student s in studentList)
            {
                Console.WriteLine(s);
            }
        }

        static void Main(string[] args)
        {            
            List<Student> studentList = new List<Student>();
            string cont = "n";
            do
            {
                studentList.Add(GetStudent());
                Console.WriteLine("Do you want to Create one Student");
                cont = Console.ReadLine();
            }
            while (cont == "y");
            StoreStudentsInXml(studentList);
            studentList = null;
            studentList = RetriveStudentFromXml();
            DisplayStudents(studentList);

            Console.ReadKey();
        }        

    }
}
