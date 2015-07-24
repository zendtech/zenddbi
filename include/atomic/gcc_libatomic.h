#ifndef ATOMIC_GCC_BUILTINS_INCLUDED
#define ATOMIC_GCC_BUILTINS_INCLUDED

/* Copyright (c) 2008, 2010, Oracle and/or its affiliates. All rights reserved.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; version 2 of the License.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA */

/* Modified by David Lowes - 2015 Zend Technologies */

#define ATOMIC_COMPARE_WEAK_VALIDATION FALSE

#define make_atomic_add_body(S)                     \
    v= __atomic_fetch_add(a, v, __ATOMIC_SEQ_CST);
#define make_atomic_fas_body(S)                     \
    v= __atomic_exchange_n(a, v, __ATOMIC_SEQ_CST);
#define make_atomic_cas_body(S)                     \
ret= __atomic_compare_exchange_n(a, cmp, set, ATOMIC_COMPARE_WEAK_VALIDATION, __ATOMIC_SEQ_CST, __ATOMIC_SEQ_CST);\



#define MY_ATOMIC_MODE "gcc-atomics-smp"
    #define make_atomic_load_body(S)                    \
        ret= __atomic_load_n(a, __ATOMIC_SEQ_CST)
    #define make_atomic_store_body(S)                   \
        __atomic_store_n(a, v, __ATOMIC_SEQ_CST)


#ifdef MY_ATOMIC_MODE_DUMMY
    #define make_atomic_load_body(S)   ret= *a
    #define make_atomic_store_body(S)  *a= v
    #define MY_ATOMIC_MODE "gcc-builtins-up"
#endif

#endif /* ATOMIC_GCC_BUILTINS_INCLUDED */
