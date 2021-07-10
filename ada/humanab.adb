with Ada.Containers.Indefinite_Vectors; use Ada.Containers;
with Ada.Strings;                       use Ada.Strings;
with Ada.Strings.Fixed;                 use Ada.Strings.Fixed;
with Ada.Text_IO;                       use Ada.Text_IO;
with Ada.Integer_Text_IO;               use Ada.Integer_Text_IO;
with Ada.Numerics.Discrete_Random;

procedure HumanAB is

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
   Number        : Integer;
   Answer        : String (1 .. 4) := "1234";
   UserAns       : String (1 .. 4) := "1234";
   CountA        : Integer         := 0;
   CountB        : Integer         := 0;

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
      Put ("Please input a number to guess: ");
      Get (Number);
      if Number < 1 or Number > 9999 then
          Put_Line("It is not a valid number.");
          goto Continue;
      end if;

      UserAns := Tail (Trim (Integer'Image (Number), Both), 4, '0');

      CountA := getA (Answer, UserAns);
      CountB := getB (Answer, UserAns);
      Put_Line
        ("Result:  A is " & Integer'Image (CountA) & ", B is " &
         Integer'Image (CountB) & ".");
      if CountA = 4 and CountB = 0 then
         Put_Line ("You guess the correct answer.");
         exit;
      end if;
      <<Continue>>
      New_Line;
   end loop;

end HumanAB;
