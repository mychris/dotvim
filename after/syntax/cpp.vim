" semi important types for the OpenJDK
" Most types should not have been defined in the first place...
syn keyword cppType jbyte jubyte jchar juchar jshort jushort
syn keyword cppType jint juint jlong julong jfloat jdouble
syn keyword cppType jboolean jobject
syn keyword cppType s_char u_char uint intx uintx
syn keyword cppType s1 s2 s4 s8 u1 u2 u4 u8
syn keyword cppType address address_word

" Constants for the OpenJDK which are very important
" Used for the macro assembler. Sometimes very hard to spot.
syn keyword cppConstant __

