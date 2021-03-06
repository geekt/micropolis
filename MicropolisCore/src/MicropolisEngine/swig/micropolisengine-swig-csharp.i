/* micropolisengine-swig-csharp.i
 *
 * Micropolis, Unix Version.  This game was released for the Unix platform
 * in or about 1990 and has been modified for inclusion in the One Laptop
 * Per Child program.  Copyright (C) 1989 - 2007 Electronic Arts Inc.  If
 * you need assistance with this program, you may contact:
 *   http://wiki.laptop.org/go/Micropolis  or email  micropolis@laptop.org.
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or (at
 * your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.  You should have received a
 * copy of the GNU General Public License along with this program.  If
 * not, see <http://www.gnu.org/licenses/>.
 * 
 *             ADDITIONAL TERMS per GNU GPL Section 7
 * 
 * No trademark or publicity rights are granted.  This license does NOT
 * give you any right, title or interest in the trademark SimCity or any
 * other Electronic Arts trademark.  You may not distribute any
 * modification of this program using the trademark SimCity or claim any
 * affliation or association with Electronic Arts Inc. or its employees.
 * 
 * Any propagation or conveyance of this program must include this
 * copyright notice and these terms.
 * 
 * If you convey this program (or any modifications of it) and assume
 * contractual liability for the program to recipients of it, you agree
 * to indemnify Electronic Arts for any liability that those contractual
 * assumptions impose on Electronic Arts.
 * 
 * You may not misrepresent the origins of this program; modified
 * versions of the program must be marked as such and not identified as
 * the original program.
 * 
 * This disclaimer supplements the one included in the General Public
 * License.  TO THE FULLEST EXTENT PERMISSIBLE UNDER APPLICABLE LAW, THIS
 * PROGRAM IS PROVIDED TO YOU "AS IS," WITH ALL FAULTS, WITHOUT WARRANTY
 * OF ANY KIND, AND YOUR USE IS AT YOUR SOLE RISK.  THE ENTIRE RISK OF
 * SATISFACTORY QUALITY AND PERFORMANCE RESIDES WITH YOU.  ELECTRONIC ARTS
 * DISCLAIMS ANY AND ALL EXPRESS, IMPLIED OR STATUTORY WARRANTIES,
 * INCLUDING IMPLIED WARRANTIES OF MERCHANTABILITY, SATISFACTORY QUALITY,
 * FITNESS FOR A PARTICULAR PURPOSE, NONINFRINGEMENT OF THIRD PARTY
 * RIGHTS, AND WARRANTIES (IF ANY) ARISING FROM A COURSE OF DEALING,
 * USAGE, OR TRADE PRACTICE.  ELECTRONIC ARTS DOES NOT WARRANT AGAINST
 * INTERFERENCE WITH YOUR ENJOYMENT OF THE PROGRAM; THAT THE PROGRAM WILL
 * MEET YOUR REQUIREMENTS; THAT OPERATION OF THE PROGRAM WILL BE
 * UNINTERRUPTED OR ERROR-FREE, OR THAT THE PROGRAM WILL BE COMPATIBLE
 * WITH THIRD PARTY SOFTWARE OR THAT ANY ERRORS IN THE PROGRAM WILL BE
 * CORRECTED.  NO ORAL OR WRITTEN ADVICE PROVIDED BY ELECTRONIC ARTS OR
 * ANY AUTHORIZED REPRESENTATIVE SHALL CREATE A WARRANTY.  SOME
 * JURISDICTIONS DO NOT ALLOW THE EXCLUSION OF OR LIMITATIONS ON IMPLIED
 * WARRANTIES OR THE LIMITATIONS ON THE APPLICABLE STATUTORY RIGHTS OF A
 * CONSUMER, SO SOME OR ALL OF THE ABOVE EXCLUSIONS AND LIMITATIONS MAY
 * NOT APPLY TO YOU.
 */


////////////////////////////////////////////////////////////////////////


%module micropolisengine

%include <stl.i>
%include <arrays_csharp.i>
%include <typemaps.i>

%{
////////////////////////////////////////////////////////////////////////
// Headers inserted into micropolisengine_wrap.cpp,
// from micropolisengine-swig-csharp.i
#include "micropolis.h"
#include "generate.h"
#include "text.h"
%}


%include "data_types.h"
%include "map_type.h"
%include "micropolis.h"
%include "generate.h"
%include "text.h"


////////////////////////////////////////////////////////////////////////
// Typemaps
//
// Tell SWIG how to pass certain data types in and out.

%typemap(in) const char * { $1 = const string $input; }
%typemap(in) char * { $1 = new string($input); }
%typemap(in) unsigned char * { $1 = new string($input); }


////////////////////////////////////////////////////////////////////////
// Need to figure out how to define typemaps for these types
// ToolEffects (connect.cpp)
// Position (disasters.cpp)


////////////////////////////////////////////////////////////////////////
// Templates
//
// Tell SWIG to write wrappers for the templates that we're 
// instantiating for the maps (and any other necessary templates), 
// so we can access them from the scripting language.

%template(MapByte1) Map<Byte, 1>;
%template(MapByte2) Map<Byte, 2>;
%template(MapByte4) Map<Byte, 4>;
%template(MapShort8) Map<short, 8>;


////////////////////////////////////////////////////////////////////////
// Need a way to handle = operator for the Map class? (map_type.h)

%ignore *::operator=;


////////////////////////////////////////////////////////////////////////
// Wrap any pointers

%apply float *INOUT { float *result };


////////////////////////////////////////////////////////////////////////
// The following macro calls allow you to pass arrays of primitive
// types. Arrays of other things such as System.Drawing.Point are
// also possible.

%define %cs_marshal_array(TYPE, CSTYPE)
        %typemap(ctype)  TYPE[] "void*"
        %typemap(imtype,
inattributes="[MarshalAs(UnmanagedType.LPArray)]") TYPE[] "CSTYPE[]"
        %typemap(cstype) TYPE[] "CSTYPE[]"
        %typemap(in)     TYPE[] %{ $1 = (TYPE*)$input; %}
        %typemap(csin)   TYPE[] "$csinput"
%enddef

%cs_marshal_array(bool, bool)
%cs_marshal_array(short, short)
%cs_marshal_array(unsigned short, ushort)
%cs_marshal_array(int, int)
%cs_marshal_array(unsigned int, uint)
%cs_marshal_array(long, int)
%cs_marshal_array(unsigned long, uint)
%cs_marshal_array(long long, long)
%cs_marshal_array(unsigned long long, ulong)
%cs_marshal_array(float, float)
%cs_marshal_array(double, double) 
