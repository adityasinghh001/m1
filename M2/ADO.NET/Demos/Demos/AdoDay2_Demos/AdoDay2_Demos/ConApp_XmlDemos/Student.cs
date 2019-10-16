using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConApp_XmlDemos
{
    class Student
    {
        public int RollNo { get; set; }
        public string Name { get; set; }
        public float Marks1 { get; set; }
        public float Marks2 { get; set; }
        public float Marks3 { get; set; }
        public float Avg { get; set; }

        public void CalcAvg()
        {
            this.Avg = (Marks1 + Marks2 + Marks3) / 3;
        }

        public override string ToString()
        {
            return "RollNo : " + RollNo + ", Stud Name : " + Name + ", Marks1 : " + Marks1 + ", Marks2 : " + Marks2 + ", Marks3 : " + Marks3 + ", Avg : " + Avg;
        }
    }
}
