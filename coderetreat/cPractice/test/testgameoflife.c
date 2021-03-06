#include <stdio.h>
#include "CUnit/Basic.h"
#include "gameoflife.h"

void test_gameOfLife(void)
{
  CU_ASSERT(1);
}

void test_gameOfLifeFail(void)
{
  CU_ASSERT(0);
}


int init_suite(void)
{
  return 0;
}


int clean_suite(void)
{
  return 0;
}

/* The main() function for setting up and running the tests.
 * Returns a CUE_SUCCESS on successful running, another
 * CUnit error code on failure.
 */
int main()
{
   CU_pSuite pSuite = NULL;

   /* initialize the CUnit test registry */
   if (CUE_SUCCESS != CU_initialize_registry())
      return CU_get_error();

   /* add a suite to the registry */
   pSuite = CU_add_suite("Suite_gameOfLife", init_suite, clean_suite);
   if (NULL == pSuite) {
      CU_cleanup_registry();
      return CU_get_error();
   }

   /* add the tests to the suite */
   /* NOTE - ORDER IS IMPORTANT - MUST TEST fread() AFTER fprintf() */
   if ((NULL == CU_add_test(pSuite, "test of gameOfLife", test_gameOfLife)) ||
       (NULL == CU_add_test(pSuite, "test of gameOfLifeFail", test_gameOfLifeFail)))
   {
      CU_cleanup_registry();
      return CU_get_error();
   }

   /* Run all tests using the CUnit Basic interface */
   CU_basic_set_mode(CU_BRM_VERBOSE);
   CU_basic_run_tests();
   CU_cleanup_registry();
   return CU_get_error();
}
