<template>
  <div class="min-h-screen bg-gray-50">
    <!-- 導航欄 -->
    <AppNavigation 
      title="編輯課程"
      :show-back-button="true"
      :back-route="route('courses.index')"
      back-text="返回課程列表"
    />

    <div class="max-w-3xl mx-auto py-6 px-4 sm:px-6 lg:px-8">
      <div class="bg-white rounded-lg shadow p-6">
        <form @submit.prevent="submit" class="space-y-6">
          <div>
            <label for="course_name" class="block text-sm font-medium text-gray-700">
              課程名稱 *
            </label>
            <input
              id="course_name"
              v-model="form.course_name"
              type="text"
              class="mt-1 block w-full px-4 py-3 text-gray-900 border-gray-300 rounded-lg shadow-sm focus:ring-2 focus:ring-blue-500 focus:border-blue-500 text-base"
              :class="{ 'border-red-500': form.errors.course_name }"
              required
            />
            <p v-if="form.errors.course_name" class="mt-1 text-sm text-red-600">
              {{ form.errors.course_name }}
            </p>
          </div>

          <div>
            <label for="course_code" class="block text-sm font-medium text-gray-700">
              課程代碼 *
            </label>
            <input
              id="course_code"
              v-model="form.course_code"
              type="text"
              class="mt-1 block w-full px-4 py-3 text-gray-900 border-gray-300 rounded-lg shadow-sm focus:ring-2 focus:ring-blue-500 focus:border-blue-500 text-base"
              :class="{ 'border-red-500': form.errors.course_code }"
              placeholder="例如: CS101"
              required
            />
            <p v-if="form.errors.course_code" class="mt-1 text-sm text-red-600">
              {{ form.errors.course_code }}
            </p>
          </div>

          <div>
            <label for="instructor" class="block text-sm font-medium text-gray-700">
              授課教師 *
            </label>
            <input
              id="instructor"
              v-model="form.instructor"
              type="text"
              class="mt-1 block w-full px-4 py-3 text-gray-900 border-gray-300 rounded-lg shadow-sm focus:ring-2 focus:ring-blue-500 focus:border-blue-500 text-base"
              :class="{ 'border-red-500': form.errors.instructor }"
              required
            />
            <p v-if="form.errors.instructor" class="mt-1 text-sm text-red-600">
              {{ form.errors.instructor }}
            </p>
          </div>

          <div>
            <label for="time_slot" class="block text-sm font-medium text-gray-700">
              上課時間 *
            </label>
            <input
              id="time_slot"
              v-model="form.time_slot"
              type="text"
              class="mt-1 block w-full px-4 py-3 text-gray-900 border-gray-300 rounded-lg shadow-sm focus:ring-2 focus:ring-blue-500 focus:border-blue-500 text-base"
              :class="{ 'border-red-500': form.errors.time_slot }"
              placeholder="例如: 周一 9:00-11:00"
              required
            />
            <p v-if="form.errors.time_slot" class="mt-1 text-sm text-red-600">
              {{ form.errors.time_slot }}
            </p>
          </div>

          <div>
            <label for="location" class="block text-sm font-medium text-gray-700">
              上課地點 *
            </label>
            <input
              id="location"
              v-model="form.location"
              type="text"
              class="mt-1 block w-full px-4 py-3 text-gray-900 border-gray-300 rounded-lg shadow-sm focus:ring-2 focus:ring-blue-500 focus:border-blue-500 text-base"
              :class="{ 'border-red-500': form.errors.location }"
              placeholder="例如: 教学楼A101"
              required
            />
            <p v-if="form.errors.location" class="mt-1 text-sm text-red-600">
              {{ form.errors.location }}
            </p>
          </div>

          <div>
            <label for="credits" class="block text-sm font-medium text-gray-700">
              學分 *
            </label>
            <input
              id="credits"
              v-model="form.credits"
              type="number"
              min="0"
              max="10"
              class="mt-1 block w-full px-4 py-3 text-gray-900 border-gray-300 rounded-lg shadow-sm focus:ring-2 focus:ring-blue-500 focus:border-blue-500 text-base"
              :class="{ 'border-red-500': form.errors.credits }"
              required
            />
            <p v-if="form.errors.credits" class="mt-1 text-sm text-red-600">
              {{ form.errors.credits }}
            </p>
          </div>

          <div>
            <label for="description" class="block text-sm font-medium text-gray-700">
              課程描述
            </label>
            <textarea
              id="description"
              v-model="form.description"
              rows="4"
              class="mt-1 block w-full px-4 py-3 text-gray-900 border-gray-300 rounded-lg shadow-sm focus:ring-2 focus:ring-blue-500 focus:border-blue-500 text-base resize-none"
              :class="{ 'border-red-500': form.errors.description }"
              placeholder="課程的详细描述，包括内容、要求等..."
            ></textarea>
            <p v-if="form.errors.description" class="mt-1 text-sm text-red-600">
              {{ form.errors.description }}
            </p>
          </div>

          <div class="flex justify-end space-x-3">
            <Link :href="route('courses.index')" 
                  class="bg-gray-300 text-gray-700 px-4 py-2 rounded-md hover:bg-gray-400 transition-colors">
              取消
            </Link>
            <button
              type="submit"
              :disabled="form.processing"
              class="bg-blue-600 text-white px-4 py-2 rounded-md hover:bg-blue-700 transition-colors disabled:opacity-50"
            >
              <span v-if="form.processing">更新中...</span>
              <span v-else>更新課程</span>
            </button>
          </div>
        </form>
      </div>
    </div>

    <!-- 页脚 -->
    <AppFooter />
  </div>
</template>

<script setup>
import { Link, useForm } from '@inertiajs/vue3'
import AppNavigation from '@/components/AppNavigation.vue'
import AppFooter from '@/components/AppFooter.vue'

const props = defineProps({
  course: Object,
})

const form = useForm({
  course_name: props.course.course_name,
  course_code: props.course.course_code,
  instructor: props.course.instructor,
  time_slot: props.course.time_slot,
  location: props.course.location,
  credits: props.course.credits,
  description: props.course.description || '',
})

const submit = () => {
  form.put(route('courses.update', props.course.id))
}
</script>
