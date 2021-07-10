with Ada.Containers.Indefinite_Vectors; use Ada.Containers;
with Ada.Strings;                       use Ada.Strings;
with Ada.Strings.Fixed;                 use Ada.Strings.Fixed;
with Ada.Text_IO;                       use Ada.Text_IO;
with Ada.Integer_Text_IO;               use Ada.Integer_Text_IO;
with Ada.Numerics.Discrete_Random;

procedure ComputerAB is

   function getA (Ans1 : String; Ans2 : String) return Integer is
      Count : Integer := 0;
   begin
      if Ans1'Length /= Ans2'Length then
         return 0;
      end if;

      for I in 1 .. Ans1'Length loop
         if Ans1 (I) = Ans2 (I) then
            Count := Count + 1;
         end if;
      end loop;

      return Count;
   end getA;

   function getB (Ans1 : String; Ans2 : String) return Integer is
      Count : Integer := 0;
   begin
      if Ans1'Length /= Ans2'Length then
         return 0;
      end if;

      for I in 1 .. Ans1'Length loop
         for J in 1 .. Ans1'Length loop
            if I /= J then
               if Ans1 (I) = Ans2 (J) then
                  Count := Count + 1;
               end if;
            end if;
         end loop;
      end loop;

      return Count;
   end getB;

   package String_Vectors is new Ada.Containers.Indefinite_Vectors
     (Natural, String);
   use String_Vectors;

   subtype Small_Number is Integer range 1 .. 5_040;
   package Random_Secret is new Ada.Numerics.Discrete_Random (Small_Number);

   V             : Vector;
   Seed          : Random_Secret.Generator;
   Secret_Number : Small_Number;
   Answer        : String (1 .. 4) := "1234";
   UserAns       : String (1 .. 4) := "1234";
   CountA        : Integer         := 0;
   CountB        : Integer         := 0;
   CurrentA      : Integer         := 0;
   CurrentB      : Integer         := 0;

begin
   -- Generate our solution list
   for i in 0 .. 9 loop
      for j in 0 .. 9 loop
         for k in 0 .. 9 loop
            for m in 0 .. 9 loop
               if i /= j and i /= k and i /= m and j /= k and j /= m and k /= m
               then
                  declare
                     S : String :=
                       Trim (Integer'image (i), Both) &
                       Trim (Integer'image (j), Both) &
                       Trim (Integer'image (k), Both) &
                       Trim (Integer'image (m), Both);
                  begin
                     V.Append (S);
                  end;
               end if;
            end loop;
         end loop;
      end loop;
   end loop;

   Random_Secret.Reset (Seed);
   Secret_Number := Random_Secret.Random (Seed);

   -- Get a number to be our answer
   if Integer (Secret_Number) < Integer (V.Length) then
      Answer := V (Integer (Secret_Number));
   end if;

   loop
      Put_Line ("My answer is " & Answer);
      Put ("Please give the A value: ");
      Get (CurrentA);
      if CurrentA < 0 or CurrentA > 4 then
         Put_Line ("Invalid input.");
         goto Continue;
      end if;

      Put ("Please give the B value: ");
      Get (CurrentB);
      if CurrentB < 0 or CurrentB > 4 then
         Put_Line ("Invalid input.");
         goto Continue;
      end if;

      if CurrentA = 4 and CurrentB = 0 then
         Put_Line ("Game is completed.");
         exit;
      end if;

      declare
         SolutionSet : Vector;
      begin
         for E of V loop
            CountA := getA (E, Answer);
            CountB := getB (E, Answer);

            if (CountA = CurrentA) and (CountB = CurrentB) then
               SolutionSet.Append (E);
            end if;
         end loop;
         V := SolutionSet;
      end;

      if V.Length < 1 then
         Put_Line ("Something is wrong, close this program.");
         exit;
      end if;
      Answer := V (0);
      <<Continue>>
      New_Line;
   end loop;
end ComputerAB;
